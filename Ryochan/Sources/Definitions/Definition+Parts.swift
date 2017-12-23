//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

extension Const {
    
    /// パーツ一覧用のJSONファイル名
    static let partsJsonFileName = "parts.json"
    
    /// パーツ素材のZIPファイル名(拡張子なし)
    static let zipFileName = "Resources"
    
    /// パーツ素材画像の拡張子
    static let partsImageExtension = ".png"
    
    /// 色素材画像のサフィックス
    static let colorPartsImageSuffix = ".color"
}

extension Path {
    
    /// パーツ一覧用のJSONファイルのパス
    static var partsJsonFile: String {
        return documentDirectory.path(Const.partsJsonFileName)
    }
}
