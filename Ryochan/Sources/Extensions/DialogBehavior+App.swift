//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

extension DialogBehavior {
    
    class var menu: DialogBehavior {
        let behavior = DialogRightDrawBehavior(width: .rightDrawWidth)
        behavior.overlayIsBlur = true
        behavior.overlayBlurEffectStyle = .dark
        return behavior
    }
}

extension DialogRiseupBehavior {
    
    class func dialog(size: CGSize? = nil) -> DialogRiseupBehavior {
        let behavior = DialogRiseupBehavior(offset: 20)
        behavior.overlayIsBlur = true
        behavior.overlayBlurEffectStyle = .dark
        behavior.fixedSize = size
        return behavior
    }
    
    class func dialog(height: CGFloat) -> DialogRiseupBehavior {
        let size = CGSize(UIScreen.main.bounds.width * 0.85, height)
        return dialog(size: size)
    }
    
    static var recommend: DialogRiseupBehavior {
        let behavior = recommendNoSize
        behavior.fixedSize = .dialogLerge
        return behavior
    }
    
    static var recommendNoSize: DialogRiseupBehavior {
        let behavior = DialogRiseupBehavior(offset: 20)
        behavior.overlayIsBlur = true
        behavior.overlayBlurEffectStyle = .dark
        return behavior
    }
}

