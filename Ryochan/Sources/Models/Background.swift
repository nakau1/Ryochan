//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// 画像の背景
class Background: Codable {
    
    var resource = ""
    
    init(_ resource: String) {
        self.resource = resource
    }
    
    var image: UIImage? {
        return UIImage(path: Path.backgroundImage(self))
    }
    
    var thumbImage: UIImage? {
        return UIImage(path: Path.backgroundThumb(self))
    }
}

extension Background {
    
    class func list() -> [Background] {
        return File.decode(jsonFilePath: Path.backgroundJsonFile, to: [Background].self, defaultValue: [Background]())
    }
    
    class func thumbList() -> [UIImage?] {
        return list().map { background -> UIImage? in
            return background.thumbImage
        }
    }
    
    func writeImages() {
        writeThumbImage()
    }
    
    private func writeThumbImage() {
        File.makeDirectoryIfNeeded(to: Path.backgroundThumbDirectory)
        let thumb = image?.scaled(to: .backgroundThumb)
        thumb?.write(to: Path.backgroundThumb(self))
    }
}

extension Background: Equatable {
    
    static func ==(lhs: Background, rhs: Background) -> Bool {
        return lhs.resource == rhs.resource
    }
}
