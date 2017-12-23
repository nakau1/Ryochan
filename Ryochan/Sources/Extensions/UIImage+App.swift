//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 画像ファイルパスから画像を初期化する
    /// - parameter path: 画像ファイルパス
    convenience init?(path: String) {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        self.init(data: data)
    }
    
    /// 指定した画像ファイルパスに画像を保存する
    /// - Parameter path: 画像ファイルパス
    func write(to path: String) {
        let data = UIImagePNGRepresentation(self)
        try? data?.write(to: URL(fileURLWithPath: path), options: [.atomic])
    }
    
    /// 指定のサイズに拡大縮小した画像を生成して返す
    /// - parameter size: サイズ
    /// - returns: 拡大縮小した画像
    func scaled(to size: CGSize) -> UIImage {
        return UIImage.imageFromContext(size) { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    /// 指定の領域で切り取った画像を生成して返す
    /// - parameter rect: 切り取る領域
    /// - returns: 切り取った画像
    func cropped(to rect: CGRect) -> UIImage {
        guard let ref = cgImage?.cropping(to: rect) else {
            return UIImage.imageFromContext(rect.size) { _ in } // 空の画像
        }
        return UIImage(cgImage: ref, scale: scale, orientation: imageOrientation)
    }
    
    
    func fixed(size: CGSize) -> UIImage {
        return UIImage.imageFromContext(size) { _ in
            let rect = CGRect(
                (size.width - self.size.width) / 2,
                (size.height - self.size.height) / 2,
                self.size.width,
                self.size.height
            )
            draw(in: rect)
        }
    }
    
    /// 画像を半分に分割して返す
    /// - Returns: 左半分と右半分の画像
    func separated() -> (left: UIImage, right: UIImage) {
        let leftImage = cropped(to: CGRect(.zero, size.horizontalHalfSize))
        let rightImage = cropped(to: CGRect(size.horizontalHalfPoint, size.horizontalHalfSize))        
        return(left: leftImage, right: rightImage)
    }
    
    func masked(color: UIColor) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        let bitmap = CGImageAlphaInfo.premultipliedLast.rawValue
        let space = CGColorSpaceCreateDeviceRGB()
        
        let contextOrNil = CGContext(
            data: nil,
            width: Int(rect.width),
            height: Int(rect.height),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: space,
            bitmapInfo: bitmap
        )
        guard let context = contextOrNil else { return nil }
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let imageRef = context.makeImage()!
        context.clear(rect)
        context.clip(to: rect, mask: cgImage!)
        context.draw(imageRef, in: rect)
        return UIImage(cgImage: context.makeImage()!)
    }
    
    class func text(_ text: String, color: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 32)) -> UIImage? {
        let ns = (text as NSString)
        let attributes: [NSAttributedStringKey : Any] = [
            .font: font,
            .foregroundColor: color,
        ]
        let size = ns.size(withAttributes: attributes)
        return UIImage.imageFromContext(size) { _ in
            ns.draw(at: .zero, withAttributes: attributes)
        }
    }
    
    /// グラフィックコンテキストの描画処理をラッピングして画像を生成する(クラスメソッド)
    /// - Parameters:
    ///   - size: サイズ
    ///   - block: 描画処理
    /// - Returns: 生成した画像
    class func imageFromContext(_ size: CGSize, _ block: (CGContext)->Void) -> UIImage {
        UIGraphicsBeginImageContext(size)
        block(UIGraphicsGetCurrentContext()!)
        let ret = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return ret!
    }
}
