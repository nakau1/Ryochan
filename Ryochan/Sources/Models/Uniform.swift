//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class Uniform: Codable {
    
    /// ID
    var id = String.generateIdentifier()
    
    /// ユニフォーム名
    var name = Const.uniformDefaultName
    
    /// シャツ色
    var shirtsColor: UIColor
    
    /// パンツ色
    var pantsColor: UIColor
    
    /// 背番号色のRGB値
    var numberColor: UIColor
    
    /// 背番号の位置
    var numberPosition = UniformNumberPosition.center
    
    var sleeve1       = Parts(.sleeve1)
    var sleeve2       = Parts(.sleeve2)
    var sleeve3       = Parts(.sleeve3)
    var collar        = Parts(.collar)
    var shirtsLarge1  = Parts(.shirtsLarge1)
    var shirtsLarge2  = Parts(.shirtsLarge2)
    var shirtsLarge3  = Parts(.shirtsLarge3)
    var shirtsLarge4  = Parts(.shirtsLarge4)
    var shirtsMiddle1 = Parts(.shirtsMiddle1)
    var shirtsMiddle2 = Parts(.shirtsMiddle2)
    var shirtsMiddle3 = Parts(.shirtsMiddle3)
    var shirtsMiddle4 = Parts(.shirtsMiddle4)
    var shirtsSmall1  = Parts(.shirtsSmall1)
    var shirtsSmall2  = Parts(.shirtsSmall2)
    var shirtsSmall3  = Parts(.shirtsSmall3)
    var shirtsSmall4  = Parts(.shirtsSmall4)
    
    // MARK: - Decodable & Encodable
    
    enum Keys: String, CodingKey {
        case id
        case name
        case shirtsColor = "shirts_color"
        case pantsColor = "pants_color"
        case numberColor = "number_color"
        case numberPosition = "number_pos"
        case sleeve1
        case sleeve2
        case sleeve3
        case collar
        case shirtsLarge1 = "shirts_large1"
        case shirtsLarge2 = "shirts_large2"
        case shirtsLarge3 = "shirts_large3"
        case shirtsLarge4 = "shirts_large4"
        case shirtsMiddle1 = "shirts_middle1"
        case shirtsMiddle2 = "shirts_middle2"
        case shirtsMiddle3 = "shirts_middle3"
        case shirtsMiddle4 = "shirts_middle4"
        case shirtsSmall1 = "shirts_small1"
        case shirtsSmall2 = "shirts_small2"
        case shirtsSmall3 = "shirts_small3"
        case shirtsSmall4 = "shirts_small4"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        id             = container.string(.id, String.generateIdentifier())
        name           = container.string(.name, Const.uniformDefaultName)
        shirtsColor    = container.color(.shirtsColor, UIColor.uniformColors[0])
        pantsColor     = container.color(.pantsColor,  UIColor.uniformColors[1])
        numberColor    = container.color(.numberColor, UIColor.uniformColors[1])
        numberPosition = container.to(UniformNumberPosition.self, .numberPosition, UniformNumberPosition.center)
        sleeve1        = container.to(Parts.self, .sleeve1,       Parts(.sleeve1))
        sleeve2        = container.to(Parts.self, .sleeve2,       Parts(.sleeve2))
        sleeve3        = container.to(Parts.self, .sleeve3,       Parts(.sleeve3))
        collar         = container.to(Parts.self, .collar,        Parts(.collar))
        shirtsLarge1   = container.to(Parts.self, .shirtsLarge1,  Parts(.shirtsLarge1))
        shirtsLarge2   = container.to(Parts.self, .shirtsLarge2,  Parts(.shirtsLarge2))
        shirtsLarge3   = container.to(Parts.self, .shirtsLarge3,  Parts(.shirtsLarge3))
        shirtsLarge4   = container.to(Parts.self, .shirtsLarge4,  Parts(.shirtsLarge4))
        shirtsMiddle1  = container.to(Parts.self, .shirtsMiddle1, Parts(.shirtsMiddle1))
        shirtsMiddle2  = container.to(Parts.self, .shirtsMiddle2, Parts(.shirtsMiddle2))
        shirtsMiddle3  = container.to(Parts.self, .shirtsMiddle3, Parts(.shirtsMiddle3))
        shirtsMiddle4  = container.to(Parts.self, .shirtsMiddle4, Parts(.shirtsMiddle4))
        shirtsSmall1   = container.to(Parts.self, .shirtsSmall1,  Parts(.shirtsSmall1))
        shirtsSmall2   = container.to(Parts.self, .shirtsSmall2,  Parts(.shirtsSmall2))
        shirtsSmall3   = container.to(Parts.self, .shirtsSmall3,  Parts(.shirtsSmall3))
        shirtsSmall4   = container.to(Parts.self, .shirtsSmall4,  Parts(.shirtsSmall4))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(id,              forKey: .id)
        try container.encode(name,            forKey: .name)
        try container.encode(shirtsColor.rgb, forKey: .shirtsColor)
        try container.encode(pantsColor.rgb,  forKey: .pantsColor)
        try container.encode(numberColor.rgb, forKey: .numberColor)
        try container.encode(numberPosition,  forKey: .numberPosition)
        try container.encode(sleeve1,         forKey: .sleeve1)
        try container.encode(sleeve2,         forKey: .sleeve2)
        try container.encode(sleeve3,         forKey: .sleeve3)
        try container.encode(collar,          forKey: .collar)
        try container.encode(shirtsLarge1,    forKey: .shirtsLarge1)
        try container.encode(shirtsLarge2,    forKey: .shirtsLarge2)
        try container.encode(shirtsLarge3,    forKey: .shirtsLarge3)
        try container.encode(shirtsLarge4,    forKey: .shirtsLarge4)
        try container.encode(shirtsMiddle1,   forKey: .shirtsMiddle1)
        try container.encode(shirtsMiddle2,   forKey: .shirtsMiddle2)
        try container.encode(shirtsMiddle3,   forKey: .shirtsMiddle3)
        try container.encode(shirtsMiddle4,   forKey: .shirtsMiddle4)
        try container.encode(shirtsSmall1,    forKey: .shirtsSmall1)
        try container.encode(shirtsSmall2,    forKey: .shirtsSmall2)
        try container.encode(shirtsSmall3,    forKey: .shirtsSmall3)
        try container.encode(shirtsSmall4,    forKey: .shirtsSmall4)
    }
}

extension Uniform {
    
    func add() {
        var list = Uniform.list()
        list.append(self)
        list.write()
        writeImages()
    }
    
    func save() {
        var list = Uniform.list()
        if let index = list.index(of: self) {
            list[index] = self
            list.write()
            writeImages()
        }
    }
    
    func copy() {
        let cloned = File.cloneData(self, type: Uniform.self)
        cloned.id = String.generateIdentifier()
        var list = Uniform.list()
        list.append(cloned)
        list.write()
        cloned.writeImages()
    }
    
    func delete() {
        Uniform.list().filter { $0 != self }.write()
        deleteImages()
    }
    
    func setResource(_ resource: String, for category: Category) {
        category.parts(of: self).resource = resource
    }
    
    func generateImage() -> UIImage {
        return UniformImageGenerator().generateImage(of: self)
    }
    
    func generateThumbImage() -> UIImage {
        return generateImage().scaled(to: .portraitThumb)
    }
    
    class func list() -> [Uniform] {
        if File.makeFileIfNeeded(to: Path.uniformsJsonFile) {
            makeDefaultList()
        }
        return File.decode(jsonFilePath: Path.uniformsJsonFile, to: [Uniform].self, defaultValue: [Uniform]())
    }
    
    class func thumbList() -> [UIImage?] {
        return list().map { uniform -> UIImage? in
            return UIImage(path: Path.uniformThumb(uniform))
        }
    }
    
    class func reset() {
        [Uniform]().write()
    }
    
    class func search(id: String) -> Uniform? {
        if id.isEmpty { return nil }
        for uniform in list() {
            if uniform.id == id {
                return uniform
            }
        }
        return nil
    }
    
    static var defaultBaseUniform: Uniform {
        let ret = Uniform.create()
        ret.id = "default"
        ret.shirtsColor = .white
        ret.pantsColor = .white
        return ret
    }
}

private extension Uniform {
    
    // MARK: default list
    
    class func makeDefaultList() {
        (0..<Const.uniformMinimumNumber).map { _ -> Uniform in
            let uniform = Uniform.create()
            uniform.writeImages()
            return uniform
        }.write()
    }
    
    // MARK: write image
    
    func writeImages() {
        writeThumbImage()
    }
    
    func writeThumbImage() {
        File.makeDirectoryIfNeeded(to: Path.uniformThumbDirectory)
        generateThumbImage().write(to: Path.uniformThumb(self))
    }
    
    // MARK: delete image
    
    func deleteImages() {
        deleteThumbImage()
    }
    
    func deleteThumbImage() {
        File.deleteFile(at: Path.uniformThumb(self))
    }
}


extension Uniform: Equatable {
    
    static func ==(lhs: Uniform, rhs: Uniform) -> Bool {
        return lhs.id == rhs.id
    }
}

private extension Array where Element == Uniform {
    
    func write() {
        File.writeEncoded(self, to: Path.uniformsJsonFile)
    }
    
    func index(of uniform: Uniform) -> Int? {
        for (i, element) in self.enumerated() {
            if element == uniform {
                return i
            }
        }
        return nil
    }
}
