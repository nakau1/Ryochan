//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// パーツカテゴリ
enum Category: String, Codable {
    // for Portrait
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
    // for Uniform
    case sleeve1
    case sleeve2
    case sleeve3
    case collar
    case shirtsLarge1
    case shirtsLarge2
    case shirtsLarge3
    case shirtsLarge4
    case shirtsMiddle1
    case shirtsMiddle2
    case shirtsMiddle3
    case shirtsMiddle4
    case shirtsSmall1
    case shirtsSmall2
    case shirtsSmall3
    case shirtsSmall4
}

extension Category {
    
    /// カテゴリ
    static var items: [Category] {
        return portraitItems + uniformItems
    }
    
    /// 似顔絵パーツカテゴリの並び順
    static var portraitItems: [Category] {
        return [.contour, .baseHair, .hair, .backHair, .eye, .brows, .nose, .mouth, .mustache, .beard, .accessory]
    }
    
    /// ユニフォームパーツカテゴリの並び順
    static var uniformItems: [Category] {
        return [
            .sleeve1, .sleeve2, .sleeve3,
            .collar,
            .shirtsLarge1, .shirtsLarge2, .shirtsLarge3, .shirtsLarge4,
            .shirtsMiddle1, .shirtsMiddle2, .shirtsMiddle3, shirtsMiddle4,
            .shirtsSmall1, .shirtsSmall2, .shirtsSmall3, shirtsSmall4,
        ]
    }
    
    /// [パーツカテゴリ : リソースファイル名の配列] 形式の辞書を返す
    /// - Returns: 辞書データ
    static func list() -> [Category: [String]] {
        let deserialized = File.deserialize(
            jsonFilePath: Path.partsJsonFile,
            to:           [String : [String]].self,
            defaultValue: [:]
        )
        return deserialized.reduce(into: [Category: [String]]()) { res, elem in
            if let category = Category(rawValue: elem.key) {
                res[category] = elem.value
            }
        }
    }
    
    /// パーツカテゴリ名
    var name: String {
        switch self {
        case .contour:   return "輪郭"
        case .baseHair:  return "ベース髪型"
        case .hair:      return "髪型"
        case .backHair:  return "後ろ髪"
        case .eye:       return "目"
        case .brows:     return "まゆ毛"
        case .nose:      return "鼻"
        case .mouth:     return "口"
        case .mustache:  return "くちヒゲ"
        case .beard:     return "あごヒゲ"
        case .accessory: return "その他"
            
        case .sleeve1:       return "袖1"
        case .sleeve2:       return "袖2"
        case .sleeve3:       return "袖3"
        case .collar:        return "襟"
        case .shirtsLarge1:  return "シャツ(大)1"
        case .shirtsLarge2:  return "シャツ(大)2"
        case .shirtsLarge3:  return "シャツ(大)3"
        case .shirtsLarge4:  return "シャツ(大)4"
        case .shirtsMiddle1: return "シャツ(中)1"
        case .shirtsMiddle2: return "シャツ(中)2"
        case .shirtsMiddle3: return "シャツ(中)3"
        case .shirtsMiddle4: return "シャツ(中)4"
        case .shirtsSmall1:  return "シャツ(小)1"
        case .shirtsSmall2:  return "シャツ(小)2"
        case .shirtsSmall3:  return "シャツ(小)3"
        case .shirtsSmall4:  return "シャツ(小)4"
        }
    }
    
    /// 最初に選択されるリソース
    var initialResource: String {
        switch self {
        case .contour:  return "contour001.png"
        case .baseHair: return "basehair001.png"
        case .hair:     return "hair001.png"
        case .eye:      return "eye001.png"
        case .brows:    return "brows001.png"
        case .mouth:    return "mouth009.png"
        case .sleeve1:  return "sleeve001.png"
        case .collar:   return "collar001.png"
        default: return ""
        }
    }
    
    /// パーツの初期位置
    var initialPosition: CGPoint {
        switch self {
        case .eye:      return CGPoint(x: 130, y: 235)
        case .brows:    return CGPoint(x: 130, y: 210)
        case .nose:     return CGPoint(x: 150, y: 300)
        case .mouth:    return CGPoint(x: 150, y: 360)
        case .mustache: return CGPoint(x: 150, y: 340)
        case .beard:    return CGPoint(x: 150, y: 418)
        default: return .zero
        }
    }
    
    /// 指定したパーツカテゴリの似顔絵オブジェクトのパーツを取得する
    /// - Parameter portrait: パーツカテゴリ
    /// - Returns: 似顔絵オブジェクトのパーツ
    func parts(of portrait: Portrait) -> Parts! {
        switch self {
        case .contour:   return portrait.contour
        case .baseHair:  return portrait.baseHair
        case .hair:      return portrait.hair
        case .backHair:  return portrait.backHair
        case .eye:       return portrait.eye
        case .brows:     return portrait.brows
        case .nose:      return portrait.nose
        case .mouth:     return portrait.mouth
        case .mustache:  return portrait.mustache
        case .beard:     return portrait.beard
        case .accessory: return portrait.accessory
        default: return nil
        }
    }
    
    /// 指定したパーツカテゴリのユニフォームオブジェクトのパーツを取得する
    /// - Parameter portrait: パーツカテゴリ
    /// - Returns: ユニフォームオブジェクトのパーツ
    func parts(of uniform: Uniform) -> Parts! {
        switch self {
        case .sleeve1:       return uniform.sleeve1
        case .sleeve2:       return uniform.sleeve2
        case .sleeve3:       return uniform.sleeve3
        case .collar:        return uniform.collar
        case .shirtsLarge1:  return uniform.shirtsLarge1
        case .shirtsLarge2:  return uniform.shirtsLarge2
        case .shirtsLarge3:  return uniform.shirtsLarge3
        case .shirtsLarge4:  return uniform.shirtsLarge4
        case .shirtsMiddle1: return uniform.shirtsMiddle1
        case .shirtsMiddle2: return uniform.shirtsMiddle2
        case .shirtsMiddle3: return uniform.shirtsMiddle3
        case .shirtsMiddle4: return uniform.shirtsMiddle4
        case .shirtsSmall1:  return uniform.shirtsSmall1
        case .shirtsSmall2:  return uniform.shirtsSmall2
        case .shirtsSmall3:  return uniform.shirtsSmall3
        case .shirtsSmall4:  return uniform.shirtsSmall4
        default: return nil
        }
    }
    
    /// パーツの可動タイプ
    var movableType: MovableType {
        switch self {
        case .contour:   return .notMovable
        case .baseHair:  return .notMovable
        case .hair:      return .vertically(area: 100)
        case .backHair:  return .notMovable
        case .eye:       return .both(area: 100)
        case .brows:     return .both(area: 100)
        case .nose:      return .vertically(area: 60)
        case .mouth:     return .vertically(area: 100)
        case .mustache:  return .vertically(area: 50)
        case .beard:     return .vertically(area: 50)
        case .accessory: return .freely
        default: return .notMovable
        }
    }
    
    /// 「なし」を先頭に置くかどうか
    var hasEmpty: Bool {
        switch self {
        case .baseHair, .backHair, .hair, .brows, .nose, .mouth, .mustache, .beard, .accessory:
            return true
        case .sleeve1, .sleeve2, .sleeve3,
             .collar,
             .shirtsLarge1,  .shirtsLarge2,  .shirtsLarge3,  .shirtsLarge4,
             .shirtsMiddle1, .shirtsMiddle2, .shirtsMiddle3, .shirtsMiddle4,
             .shirtsSmall1,  .shirtsSmall2,  .shirtsSmall3,  .shirtsSmall4:
            return true
        default:
            return false
        }
    }
    
    /// 色変更種別
    var partsColorType: PartsColorType {
        switch self {
        case .contour, .baseHair, .hair, .backHair:
            return .outlinedColorable
        case .sleeve1, .sleeve2, .sleeve3,
             .collar,
             .shirtsLarge1,  .shirtsLarge2,  .shirtsLarge3,  .shirtsLarge4,
             .shirtsMiddle1, .shirtsMiddle2, .shirtsMiddle3, .shirtsMiddle4,
             .shirtsSmall1,  .shirtsSmall2,  .shirtsSmall3,  .shirtsSmall4:
            return .colorable
        default:
            return .none
        }
    }
    
    /// 選択できる色の種類
    var colors: [UIColor] {
        switch self {
        case .contour:  return UIColor.skinColors
        case .baseHair: return UIColor.baseHairColors
        case .hair:     return UIColor.hairColors
        case .backHair: return UIColor.hairColors
        case .sleeve1, .sleeve2, .sleeve3,
             .collar,
             .shirtsLarge1,  .shirtsLarge2,  .shirtsLarge3,  .shirtsLarge4,
             .shirtsMiddle1, .shirtsMiddle2, .shirtsMiddle3, .shirtsMiddle4,
             .shirtsSmall1,  .shirtsSmall2,  .shirtsSmall3,  .shirtsSmall4:
            return UIColor.uniformColors
        default: return []
        }
    }
    
    var hasColor: Bool {
        return partsColorType != .none
    }
    
    /// ファイル名
    var fileBaseName: String {
        switch self {
        case .sleeve1, .sleeve2, .sleeve3:
            return "sleeve"
        case .shirtsLarge1,  .shirtsLarge2,  .shirtsLarge3,  .shirtsLarge4:
            return "shirtslarge"
        case .shirtsMiddle1, .shirtsMiddle2, .shirtsMiddle3, .shirtsMiddle4:
            return "shirtsmiddle"
        case .shirtsSmall1,  .shirtsSmall2,  .shirtsSmall3,  .shirtsSmall4:
            return "shirtssmall"
        default:
            return rawValue.lowercased()
        }
    }
}
