//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

@IBDesignable class RoundedBorderedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : .clear
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
