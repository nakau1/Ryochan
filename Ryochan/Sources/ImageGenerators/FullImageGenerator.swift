//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class FullImageGenerator {
    
    func generateImage(of portrait: Portrait, uniform uniformOrNil: Uniform? = nil) -> UIImage? {
        let uniform = uniformOrNil ?? portrait.baseUniform
        let portraitImage = UIImage(path: Path.portraitImage(portrait))
        let uniformImage = UniformImageGenerator().generateImage(of: uniform, portrait: portrait)
        
        var image = UIImage.imageFromContext(CGSize(1000, 1000)) { _ in
            uniformImage.draw(in: CGRect(CGPoint(250, 400) , CGSize(500, 500) ))
            portraitImage?.draw(in: CGRect(250, 0, 500, 500))
            
            drawUniformNumber(of: portrait, uniform: uniform)
//            let im = UIImage.text("ああ")!
//            im.draw(in: CGRect(CGPoint(250, 400), im.size))
        }
        image = image.cropped(to: CGRect(280, 0, 440, 780))//450,810
        
        //image.write(to: Path.zipDestination("test"))
        return image
    }
    
    private func drawUniformNumber(of portrait: Portrait, uniform: Uniform) {
        if let image = imageUniformNumber(of: portrait, uniform: uniform) {
            let position = CGPoint(
                uniform.numberPosition.centerPosition.x - (image.size.width / 2),
                uniform.numberPosition.centerPosition.y - (image.size.height / 2)
            )
            image.draw(in: CGRect(position, image.size))
        }
    }
    
    private func imageUniformNumber(of portrait: Portrait, uniform: Uniform) -> UIImage? {
        if uniform.numberPosition == .none {
            return nil
        }
        return UIImage.text(
            portrait.uniformNumber.string,
            color: uniform.numberColor,
            font:  uniform.numberPosition.font
        )
    }
}
