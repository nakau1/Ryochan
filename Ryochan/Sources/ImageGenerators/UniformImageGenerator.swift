//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// ユニフォーム画像を生成するクラス
class UniformImageGenerator: CompoundedImageGeneratable {
    
    private var uniform: Uniform!
    private var portrait: Portrait?
    
    func generateImage(of uniform: Uniform, portrait: Portrait? = nil) -> UIImage {
        self.uniform = uniform
        self.portrait = portrait
        return generateImage()
    }
    
    var compoundOrder: [Parts] {
        return [
            uniform.sleeve1,
            uniform.sleeve2,
            uniform.sleeve3,
            uniform.collar,
            uniform.shirtsLarge1,
            uniform.shirtsLarge2,
            uniform.shirtsLarge3,
            uniform.shirtsLarge4,
            uniform.shirtsMiddle1,
            uniform.shirtsMiddle2,
            uniform.shirtsMiddle3,
            uniform.shirtsMiddle4,
            uniform.shirtsSmall1,
            uniform.shirtsSmall2,
            uniform.shirtsSmall3,
            uniform.shirtsSmall4,
        ]
    }
    
    var destinationImageSize: CGSize {
        return CGSize.uniform
    }
    
    func beforeCompound() {
        let spikeColor = portrait?.spikeColor ?? #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        drawImage(UIImage(named: "shirts-color")!.masked(color: uniform.shirtsColor)!, position: .zero)
        drawImage(UIImage(named: "pants-color")!.masked(color: uniform.pantsColor)!, position: .zero)
        drawImage(UIImage(named: "spike-color")!.masked(color: spikeColor)!, position: .zero)
    }
    
    func afterCompound() {
        let skinColor = portrait?.skinColor ?? UIColor.skinColors.first!
        drawImage(UIImage(named: "bodyskin-color")!.masked(color: skinColor)!, position: .zero)
        drawImage(UIImage(named: "uniform-line")!, position: .zero)
    }
}
