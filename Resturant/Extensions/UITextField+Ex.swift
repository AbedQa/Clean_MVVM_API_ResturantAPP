//
//  UITextField+Ex.swift
//
//  Created by Abed Qassim on 10/10/20.
//

import UIKit

@IBDesignable
extension UITextField {
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }

    @IBInspectable var setImageLeft: UIImage? {
        get{
            return nil
        }
        set{
            let imageView =  UIImageView(image: newValue)
            imageView.frame = CGRect(x: paddingLeftCustom, y: 8, width: 20, height: 20)
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20 * 2, height: 20 * 2))
            leftView?.addSubview(imageView)
        }
        
    }
    @IBInspectable var setImageRight: UIImage? {
        get{
            return nil
        }
        set{
            let imageView =  UIImageView(image: newValue)
            imageView.frame = CGRect(x: paddingRightCustom, y: 8, width: 20, height: 20)
            rightView = UIView(frame:  CGRect(x: 0, y: 0, width: 20 * 2, height: 20 * 2))
            rightView?.addSubview(imageView)
        }
        
    }
}
