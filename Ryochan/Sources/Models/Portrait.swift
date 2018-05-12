//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// 似顔絵(選手)
class Portrait: Codable {
    
    /// ID
    var id = String.generateIdentifier()
    
    /// 選手名
    var name = Const.portraitDefaultName
    
    /// ユニフォーム
    var baseUniform: Uniform
    
    /// 背番号
    var uniformNumber = 10
    
    /// スパイクの色
    var spikeColor: UIColor!
    
    /// ゴールキーパーかどうかのフラグ
    var goalkeeper = false
    
    var contour   = Parts(.contour)
    var baseHair  = Parts(.baseHair)
    var hair      = Parts(.hair)
    var backHair  = Parts(.backHair)
    var eye       = Parts(.eye)
    var brows     = Parts(.brows)
    var nose      = Parts(.nose)
    var mouth     = Parts(.mouth)
    var mustache  = Parts(.mustache)
    var beard     = Parts(.beard)
    var accessory = Parts(.accessory)
    
    // MARK: - Decodable & Encodable
    
    enum Keys: String, CodingKey {
        case id
        case name
        case baseUniform = "uniform"
        case uniformNumber = "number"
        case goalkeeper = "gk"
        case spikeColor
        case contour
        case baseHair
        case hair
        case backHair
        case eye
        case brows
        case nose
        case mouth
        case mustache
        case beard
        case accessory
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        id            = container.string(.id, String.generateIdentifier())
        name          = container.string(.name, Const.portraitDefaultName)
        baseUniform   = Uniform.search(id: container.string(.baseUniform)) ?? Uniform.defaultBaseUniform
        uniformNumber = container.int(.uniformNumber, 10)
        goalkeeper    = container.bool(.goalkeeper)
        spikeColor    = container.color(.spikeColor, UIColor.spikeColors.first!)
        
        contour   = container.to(Parts.self, .contour,   Parts(.contour))
        baseHair  = container.to(Parts.self, .baseHair,  Parts(.baseHair))
        hair      = container.to(Parts.self, .hair,      Parts(.hair))
        backHair  = container.to(Parts.self, .backHair,  Parts(.backHair))
        eye       = container.to(Parts.self, .eye,       Parts(.eye))
        brows     = container.to(Parts.self, .brows,     Parts(.brows))
        nose      = container.to(Parts.self, .nose,      Parts(.nose))
        mouth     = container.to(Parts.self, .mouth,     Parts(.mouth))
        mustache  = container.to(Parts.self, .mustache,  Parts(.mustache))
        beard     = container.to(Parts.self, .beard,     Parts(.beard))
        accessory = container.to(Parts.self, .accessory, Parts(.accessory))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(id,            forKey: .id)
        try container.encode(name,          forKey: .name)
        try container.encode(uniformNumber, forKey: .uniformNumber)
        try container.encode(goalkeeper,    forKey: .goalkeeper)
        try container.encode(contour,       forKey: .contour)
        try container.encode(baseHair,      forKey: .baseHair)
        try container.encode(hair,          forKey: .hair)
        try container.encode(backHair,      forKey: .backHair)
        try container.encode(eye,           forKey: .eye)
        try container.encode(brows,         forKey: .brows)
        try container.encode(nose,          forKey: .nose)
        try container.encode(mouth,         forKey: .mouth)
        try container.encode(mustache,      forKey: .mustache)
        try container.encode(beard,         forKey: .beard )
        try container.encode(accessory,     forKey: .accessory)
        
        try container.encode(spikeColor.rgb, forKey: .spikeColor)
        try container.encode(baseUniform.id, forKey: .baseUniform)
    }
}

extension Portrait {
    
    var skinColor: UIColor {
        return contour.color
    }
    
    var nameWithNumber: String {
        return "\(uniformNumber).\(name)"
    }
}

extension Portrait {
    
    func add() {
        var list = Portrait.list()
        list.append(self)
        list.write()
        writeImages()
    }
    
    func save() {
        var list = Portrait.list()
        if let index = list.index(of: self) {
            list[index] = self
            list.write()
            writeImages()
        }
    }
    
    func copy() {
        let cloned = File.cloneData(self, type: Portrait.self)
        cloned.id = String.generateIdentifier()
        var list = Portrait.list()
        list.append(cloned)
        list.write()
        cloned.writeImages()
    }
    
    func delete() {
        Portrait.list().filter { $0 != self }.write()
        deleteImages()
    }
    
    func setResource(_ resource: String, for category: Category) {
        category.parts(of: self).resource = resource
    }
    
    func generateImage() -> UIImage {
        return PortraitImageGenerator().generateImage(of: self)
    }
    
    func generateThumbImage() -> UIImage {
        return generateImage().scaled(to: .portraitThumb)
    }
    
    func generateFullThumbImage() -> UIImage {
        return FullThumbImageGenerator().generateImage(of: self, uniform: self.baseUniform)!
    }
    
    class func list() -> [Portrait] {
        if File.makeFileIfNeeded(to: Path.portraitsJsonFile) {
            makeDefaultList()
        }
        return File.decode(jsonFilePath: Path.portraitsJsonFile, to: [Portrait].self, defaultValue: [Portrait]())
    }
    
    class func thumbList() -> [UIImage?] {
        return list().map { portrait -> UIImage? in
            return UIImage(path: Path.portraitThumb(portrait))
        }
    }
    
    class func fullThumbList() -> [UIImage?] {
        return list().map { portrait -> UIImage? in
            return UIImage(path: Path.portraitFullThumb(portrait))
        }
    }
    
    class func search(id: String) -> Portrait? {
        if id.isEmpty { return nil }
        for portrait in list() {
            if portrait.id == id {
                return portrait
            }
        }
        return nil
    }
    
    class func reset() {
        [Portrait]().write()
    }
}

private extension Portrait {
    
    class func makeDefaultList() {
        (0..<Const.portraitMinimumNumber).map { _ -> Portrait in
            let portrait = Portrait.create()
            portrait.writeImages()
            return portrait
        }.write()
    }
}

private extension Portrait {

    func writeImages() {
        writeImage()
        writeThumbImage()
        writeFullThumbImage()
    }
    
    func writeImage() {
        File.makeDirectoryIfNeeded(to: Path.portraitImageDirectory)
        generateImage().write(to: Path.portraitImage(self))
    }
    
    func writeThumbImage() {
        File.makeDirectoryIfNeeded(to: Path.portraitThumbDirectory)
        generateThumbImage().write(to: Path.portraitThumb(self))
    }
    
    func writeFullThumbImage() {
        File.makeDirectoryIfNeeded(to: Path.portraitFullThumbDirectory)
        generateFullThumbImage().write(to: Path.portraitFullThumb(self))
    }
}

private extension Portrait {
    
    func deleteImages() {
        deleteImage()
        deleteThumbImage()
        deleteFullThumbImage()
    }
    
    func deleteImage() {
        File.deleteFile(at: Path.portraitImage(self))
    }
    
    func deleteThumbImage() {
        File.deleteFile(at: Path.portraitThumb(self))
    }
    
    func deleteFullThumbImage() {
        File.deleteFile(at: Path.portraitFullThumb(self))
    }
}

extension Portrait: Equatable {
    
    static func ==(lhs: Portrait, rhs: Portrait) -> Bool {
        return lhs.id == rhs.id
    }
}

private extension Array where Element == Portrait {
    
    func write() {
        File.writeEncoded(self, to: Path.portraitsJsonFile)
    }
    
    func index(of portrait: Portrait) -> Int? {
        for (i, element) in self.enumerated() {
            if element == portrait {
                return i
            }
        }
        return nil
    }
}
