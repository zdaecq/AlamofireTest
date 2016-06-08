//
//  Extentions.swift
//  AlamofireTest
//
//  Created by zdaecqze zdaecq on 04.06.16.
//  Copyright © 2016 zdaecqze zdaecq. All rights reserved.
//

import Alamofire


// MARK: - String
public extension String {
    public var length: Int { return self.characters.count }
    
    public func toURL() -> NSURL? {
        return NSURL(string: self)
    }
}


// MARK: - Alamofire
/*Alamofire.request(...).responseObject {...}.responseDebugPrint()*/
extension Alamofire.Request {
    func responseDebugPrint() -> Self {
        return responseJSON() {
            response in

            if let  JSON: AnyObject = response.result.value,
                JSONData = try? NSJSONSerialization.dataWithJSONObject(JSON, options: .PrettyPrinted),
                prettyString = NSString(data: JSONData, encoding: NSUTF8StringEncoding) {
                print(prettyString)
            } else if let error = response.result.error {
                print("Error Debug Print: \(error.localizedDescription)")
                if let data = response.data where response.data?.length != 0 {
                    let errorJSONString = NSString(data: data, encoding:NSUTF8StringEncoding)
                    print(errorJSONString)
                }
            }
        }
    }
}

// MARK: - UIViewController
// MARK: UnwindSegue
extension UIViewController {
    @IBAction public func unwindToViewController (sender: UIStoryboardSegue){}
}

// MARK: addTapBackgroundGestureToHideKeyboard
extension UIViewController {
    
    func addTapBackgroundGestureToHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: performSegueWithIdentifier
extension UIViewController {
    
    class Box {
        let value: Any
        init(_ value: Any) {
            self.value = value
        }
    }
    
    struct AssociatedKey {
        static var ClosurePrepareForSegueKey = "ClosurePrepareForSegueKey"
        static var token: dispatch_once_t = 0
    }
    
    typealias ConfiguratePerformSegue = (UIStoryboardSegue) -> ()
    func performSegueWithIdentifier(identifier: String, sender: AnyObject?, configurate: ConfiguratePerformSegue?) {
        swizzlingPrepareForSegue()
        configuratePerformSegue = configurate
        performSegueWithIdentifier(identifier, sender: sender)
    }
    
    private func swizzlingPrepareForSegue() {
        dispatch_once(&AssociatedKey.token) {
            let originalSelector = #selector(UIViewController.prepareForSegue(_:sender:))
            let swizzledSelector = #selector(UIViewController.closurePrepareForSegue(_:sender:))
            
            let instanceClass = UIViewController.self
            let originalMethod = class_getInstanceMethod(instanceClass, originalSelector)
            let swizzledMethod = class_getInstanceMethod(instanceClass, swizzledSelector)
            
            let didAddMethod = class_addMethod(instanceClass, originalSelector,
                                               method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(instanceClass, swizzledSelector,
                                    method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
    
    func closurePrepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        configuratePerformSegue?(segue)
        closurePrepareForSegue(segue, sender: sender)
        configuratePerformSegue = nil
    }
    
    var configuratePerformSegue: ConfiguratePerformSegue? {
        get {
            let box = objc_getAssociatedObject(self, &AssociatedKey.ClosurePrepareForSegueKey) as? Box
            return box?.value as? ConfiguratePerformSegue
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.ClosurePrepareForSegueKey, Box(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}



