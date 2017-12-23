//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

extension UIButton {
    
    var title: String {
        get {
            return title(for: .normal) ?? ""
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }
    
    var image: UIImage? {
        get {
            return image(for: .normal)
        }
        set {
            setImage(newValue, for: .normal)
        }
    }
}

