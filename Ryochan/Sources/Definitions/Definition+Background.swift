//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

extension Const {
    
    /// 背景一覧用のJSONファイル名
    static let backgroundJsonFileName = "backgrounds.json"
    
    /// 背景画像の拡張子
    static let backgroundImageExtension = ".png"
    
    /// 背景画像のプレフィックス
    static let backgroundImagePrefix = "background"
    
    /// 背景一覧用の縦横比率
    static let backgroundRatio = 3.f / 4.f
}

extension Path {
    
    /// 背景一覧用のJSONファイルのパス
    static var backgroundJsonFile: String {
        return documentDirectory.path(Const.backgroundJsonFileName)
    }
    
    /// 背景サムネイル用ディレクトリのパス
    static var backgroundThumbDirectory: String {
        return documentDirectory.path("BackgroundThumbs")
    }
    
    /// 背景サムネイル画像ファイルのパス
    /// - Parameter background: 背景オブジェクト
    /// - Returns: 背景サムネイル画像ファイルのパス
    static func backgroundThumb(_ background: Background) -> String {
        return backgroundThumbDirectory.path(background.resource)
    }
    
    /// 背景画像ファイルのパス
    /// - Parameter background: 背景オブジェクト
    /// - Returns: 背景画像ファイルのパス
    static func backgroundImage(_ background: Background) -> String {
        return zipDestination(background.resource)
    }
}

/// サイズ
extension CGSize {
    
    /// 背景のサムネイルサイズ
    static let backgroundThumb = CGSize(width: 160 * Const.backgroundRatio, height: 160)
}
