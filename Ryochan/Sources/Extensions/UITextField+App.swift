//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

extension UITextField {
    
    @IBInspectable var placeholderColor : UIColor? {
        get {
            var r : NSRange? = NSMakeRange(0, 1)
            guard
                let ap = attributedPlaceholder,
                let ret = ap.attribute(.foregroundColor, at: 0, effectiveRange: &r!) as? UIColor
                else {
                    return nil
            }
            return ret
        }
        set {
            guard let color = newValue, let font = font else {
                return
            }
            let attributes: [NSAttributedStringKey : Any] = [
                .foregroundColor : color,
                .font            : font,
            ]
            let placeholder = self.placeholder ?? ""
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
    }
    
    var textValue: String {
        get {
            return text ?? ""
        }
        set {
            text = newValue
        }
    }
}
