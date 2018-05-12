//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// 幅 / 高さ
extension CGFloat {
    
    /// 画面の幅
    static let screenWidth: CGFloat = CGSize.screen.width
    
    /// ダイアログの幅
    static let dialogWidth: CGFloat = screenWidth - 32
    
    /// 右ドローメニューの幅
    static let rightDrawWidth: CGFloat = screenWidth * 0.8
}

/// サイズ
extension CGSize {
    
    /// 画面サイズ
    static let screen = UIScreen.main.bounds.size
    
    /// 似顔絵の生サイズ
    static let portrait = CGSize(width: 500, height: 500)
    
    /// ユニフォームの生サイズ
    static let uniform = CGSize(width: 500, height: 500)
    
    /// 似顔絵のサムネイルサイズ
    static let portraitThumb = CGSize(width: 200, height: 200)
    
    static var dialogLerge: CGSize {
        return CGSize(UIScreen.main.bounds.width - 32, UIScreen.main.bounds.height * 0.8)
    }
    
    static var dialogSmall: CGSize {
        return CGSize(UIScreen.main.bounds.width - 32, UIScreen.main.bounds.height * 0.5)
    }
}
