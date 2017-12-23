//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// 可動領域
///
/// - notMovable: 動かせない
/// - vertically: 垂直方向のみ動かせる
/// - freely: 自由に動かせる
/// - both: 左右対象に動かせる
enum MovableType {
    
    case notMovable
    case vertically(area: CGFloat)
    case freely
    case both(area: CGFloat)
    
    var isNotMovable: Bool {
        switch self { case .notMovable: return true default: return false }
    }
    
    var isVertically: Bool {
        switch self { case .vertically(_): return true default: return false }
    }
    
    var isFreely: Bool {
        switch self { case .freely: return true default: return false }
    }
    
    var isBoth: Bool {
        switch self { case .both(_): return true default: return false }
    }
}
