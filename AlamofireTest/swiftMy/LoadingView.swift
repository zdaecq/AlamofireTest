//
//  LoadingView.swift
//  AlamofireTest
//
//  Created by zdaecqze zdaecq on 09.06.16.
//  Copyright © 2016 zdaecqze zdaecq. All rights reserved.
//

import UIKit

//protocol Singleton {
//static var sharedInstance : Singleton.Type { get }
//init()
//}

//extension Singleton {
//static var sharedInstance = Singleton()
//}




public class LoadingView{
    
    var view : UIView!
    var activityIndicator : UIActivityIndicatorView!
    
    static let sharedInstance = LoadingView()
    
    init(){
        self.view = UIView()
        self.activityIndicator = UIActivityIndicatorView()
        
        view.frame = CGRectMake(0, 0, 80, 80)
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.zPosition = 1
        
        activityIndicator.frame = CGRectMake(0, 0, 40, 40)
        activityIndicator.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        view.addSubview(activityIndicator)
    }
    
    public func showInCenterOfView(parentView: UIView) {
        view.center = parentView.center
        parentView.addSubview(view)
        activityIndicator.startAnimating()
    }
    
    public func hide() {
        activityIndicator.stopAnimating()
        view.removeFromSuperview()
    }
}
