//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

@IBDesignable class HighlightButton: UIButton {
    
    @IBInspectable var normalBackgroundColor: UIColor = .clear {
        didSet {
            if backgroundColor == nil || backgroundColor == .clear {
                backgroundColor = normalBackgroundColor
            }
        }
    }
    
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
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = tintColor
            } else {
                UIView.animate(withDuration: 0.2, animations: { [unowned self] in
                    self.backgroundColor = self.normalBackgroundColor
                })
            }
        }
    }
}
