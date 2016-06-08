
import UIKit

@IBDesignable class DesignableTextField: UITextField {

    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var underLine: Bool = false
    @IBInspectable var underLineColor: UIColor = UIColor.whiteColor()
    @IBInspectable var underLineWidth: CGFloat = 1
    
    @IBInspectable var placeholderColor: UIColor = UIColor.clearColor() {
        didSet {
            attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSForegroundColorAttributeName: placeholderColor])
            layoutSubviews()
            
        }
    }
    
    override func drawRect(rect: CGRect) {
        if underLine {
            let underline = CAShapeLayer()
            let bezierPath = UIBezierPath()
            bezierPath.moveToPoint(CGPointMake(0, bounds.height - underLineWidth / 2))
            bezierPath.addLineToPoint(CGPointMake(bounds.width, bounds.height - underLineWidth / 2))
            underline.path = bezierPath.CGPath
            underline.strokeColor = underLineColor.CGColor
            underline.lineWidth = underLineWidth
            layer.addSublayer(underline)
            
            //let bottomBorder = CALayer()
            //bottomBorder.frame = CGRectMake(0.0, frame.size.height - underLineWidth, frame.size.width, underLineWidth);
            //bottomBorder.backgroundColor = underLineColor.CGColor
            //layer.addSublayer(bottomBorder)
        }

    }

    
}

