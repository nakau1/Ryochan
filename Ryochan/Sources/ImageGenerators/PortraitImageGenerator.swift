//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// 似顔絵画像を生成するクラス
class PortraitImageGenerator: CompoundedImageGeneratable {
    
    private var portrait: Portrait!
    
    func generateImage(of portrait: Portrait) -> UIImage {
        self.portrait = portrait
        return generateImage()
    }
    
    var compoundOrder: [Parts] {
        return [
            portrait.backHair,
            portrait.contour,
            portrait.baseHair,
            portrait.brows,
            portrait.eye,
            portrait.nose,
            portrait.mouth,
            portrait.mustache,
            portrait.beard,
            portrait.hair,
            portrait.accessory,
        ]
    }
    
    var destinationImageSize: CGSize {
        return CGSize.portrait
    }
}
