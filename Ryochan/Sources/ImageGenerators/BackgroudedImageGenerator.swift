//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// 保存/共有用の画像を生成するクラス
class BackgroudedImageGenerator {
    
    private var portrait: Portrait!
    
    func generateImage(of portrait: Portrait, background: Background, sourceImage: UIImage?) -> UIImage? {
        guard let backgroundImage = background.image else { return nil }
        return UIImage.imageFromContext(backgroundImage.size) { _ in
            backgroundImage.draw(in: CGRect(.zero, backgroundImage.size))
            
            let size: CGSize = sourceImage?.size ?? .zero
            let origin = CGPoint(
                (backgroundImage.size.width - size.width) / 2,
                (backgroundImage.size.height - size.height) / 2
            )
            sourceImage?.draw(in: CGRect(origin, size))
        }
    }
}
