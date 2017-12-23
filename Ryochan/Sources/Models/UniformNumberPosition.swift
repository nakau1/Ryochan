//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// 背番号の位置
enum UniformNumberPosition: String, Codable {
    
    case none
    case rightchest // 右胸部
    case center // 中央
    case centerabdomen // 腹部中央
    case leftabdomen // 左腹部
    
    static var items: [UniformNumberPosition] {
        return [.none, .rightchest, .center, .centerabdomen, .leftabdomen]
    }
    
    static var names: [String] {
        return items.map { $0.name }
    }
    
    var name: String {
        switch self {
        case .none: return "なし"
        case .rightchest: return "右むね"
        case .center: return "まん中"
        case .centerabdomen: return "おへそ"
        case .leftabdomen: return "左のおなか"
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .none: return 0
        case .rightchest: return 70
        case .center: return 82
        case .centerabdomen: return 80
        case .leftabdomen: return 80
        }
    }
    
    var centerPosition: CGPoint {
        switch self {
        case .none: return .zero
        case .rightchest: return CGPoint(450, 510)
        case .center: return CGPoint(500, 560)
        case .centerabdomen: return CGPoint(500, 610)
        case .leftabdomen: return CGPoint(550, 590)
        }
    }
    
    var font: UIFont {
        return UIFont(name: "HelveticaNeue-CondensedBlack", size: fontSize)!
    }
}
