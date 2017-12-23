//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

extension Const {
    
    /// フォーメーション保存用のJSONファイル名
    static let formationJsonFileName = "formation.json"
    
    /// フォーメーションのチーム名初期値
    static let formationTeamDefaultName = "JAPAN"
    
    /// フォーメーションのタイトル初期値
    static let formationTitleDefaultText = "2018.6.9\nCOLOMBIA - JAPAN"
    
    /// ポジション画像のの縦横比率
    static let positionRatio = 44.f / 70.f
}

extension Path {
    
    /// フォーメーション保存用のJSONファイルのパス
    static var formationJsonFile: String {
        return documentDirectory.path(Const.formationJsonFileName)
    }
}

/// 幅 / 高さ
extension CGFloat {
    
    /// フォーメーション(スタメン)のピッチ幅
    static let startingsFormationWidth: CGFloat = screenWidth - 8
    
    /// フォーメーション(スタメン)の各ポジション画像の幅
    static let startingsPositionWidth: CGFloat = startingsFormationWidth / 4.5
}

extension Notification.Name {
    
    static let PositionTemplateDidSelect = Notification.Name("Formation.PositionTemplateDidSelect")
}

/// サイズ
extension CGSize {
    
    /// フォーメーション各ポジション画像のサイズ
    static let startingsPositionSize = CGSize(
        width:  CGFloat.startingsPositionWidth,
        height: CGFloat.startingsPositionWidth / Const.positionRatio
    )
}
