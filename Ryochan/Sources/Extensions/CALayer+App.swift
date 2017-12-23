//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

extension CALayer {
    
    var borderUIColor: UIColor? {
        get {
            return UIColor(cgColor: borderColor!)
        }
        set {
            borderColor = newValue?.cgColor
        }
    }
}
