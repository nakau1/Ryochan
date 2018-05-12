//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

extension Const {
    
    /// 似顔絵リスト用のJSONファイル名
    static let portraitsJsonFileName = "portraits.json"
    
    /// 似顔絵の選手名のデフォルト値
    static let portraitDefaultName = "選手の名前"
    
    /// 似顔絵の最小数
    static let portraitMinimumNumber = 1
    
    /// 似顔絵の制限数(無料版)
    static let portraitLimitedNumber = 15
}

extension Path {
    
    /// 似顔絵一覧用のJSONファイルのパス
    static var portraitsJsonFile: String {
        return documentDirectory.path(Const.portraitsJsonFileName)
    }
    
    /// 似顔絵画像用ディレクトリのパス
    static var portraitImageDirectory: String {
        return Path.documentDirectory.path("PortraitImages")
    }
    
    /// 似顔絵サムネイル用ディレクトリのパス
    static var portraitThumbDirectory: String {
        return Path.documentDirectory.path("PortraitThumbs")
    }
    
    /// 似顔絵全身サムネイル用ディレクトリのパス
    static var portraitFullThumbDirectory: String {
        return Path.documentDirectory.path("PortraitFullThumbs")
    }
    
    /// 似顔絵画像ファイルのパス
    /// - Parameter portrait: 似顔絵オブジェクト
    /// - Returns: 似顔絵画像ファイルのパス
    static func portraitImage(_ portrait: Portrait) -> String {
        return portraitImageDirectory.path("\(portrait.id).png")
    }
    
    /// 似顔絵サムネイル画像ファイルのパス
    /// - Parameter portrait: 似顔絵オブジェクト
    /// - Returns: 似顔絵サムネイル画像ファイルのパス
    static func portraitThumb(_ portrait: Portrait) -> String {
        return portraitThumbDirectory.path("\(portrait.id).png")
    }
    
    /// 似顔絵全身サムネイル画像ファイルのパス
    /// - Parameter portrait: 似顔絵オブジェクト
    /// - Returns: 似顔絵全身サムネイル画像ファイルのパス
    static func portraitFullThumb(_ portrait: Portrait) -> String {
        return portraitFullThumbDirectory.path("\(portrait.id).png")
    }
}

extension Notification.Name {
    
    static let PortraitDidUpdate = Notification.Name("PortraitDidUpdate")
}

extension UIColor {
    
    static let skinColors = [#colorLiteral(red: 0.9764705882, green: 0.8431372549, blue: 0.7176470588, alpha: 1), #colorLiteral(red: 0.7843137255, green: 0.6196078431, blue: 0.4823529412, alpha: 1), #colorLiteral(red: 1, green: 0.9411764706, blue: 0.8901960784, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.8352941176, blue: 0.6274509804, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.8705882353, blue: 0.8039215686, alpha: 1)]
    static let baseHairColors = [#colorLiteral(red: 0.6352941176, green: 0.5019607843, blue: 0.3764705882, alpha: 1), #colorLiteral(red: 0.5058823529, green: 0.3098039216, blue: 0.1098039216, alpha: 1), #colorLiteral(red: 0.137254902, green: 0.09411764706, blue: 0.08235294118, alpha: 1), #colorLiteral(red: 0.3098039216, green: 0.2705882353, blue: 0.1921568627, alpha: 1)]
    static let hairColors = [#colorLiteral(red: 0.2862745098, green: 0.1607843137, blue: 0.04705882353, alpha: 1), #colorLiteral(red: 0.5058823529, green: 0.3098039216, blue: 0.1098039216, alpha: 1), #colorLiteral(red: 0.2862745098, green: 0.1607843137, blue: 0.04705882353, alpha: 1), #colorLiteral(red: 0.137254902, green: 0.09411764706, blue: 0.08235294118, alpha: 1), #colorLiteral(red: 0.4117647059, green: 0.3568627451, blue: 0.1803921569, alpha: 1), #colorLiteral(red: 0.7058823529, green: 0.6352941176, blue: 0.4156862745, alpha: 1), #colorLiteral(red: 0.5843137255, green: 0.3960784314, blue: 0.07843137255, alpha: 1), #colorLiteral(red: 0.3450980392, green: 0.1411764706, blue: 0.01960784314, alpha: 1), #colorLiteral(red: 0.4274509804, green: 0.2509803922, blue: 0.03921568627, alpha: 1), #colorLiteral(red: 0.2666666667, green: 0.1882352941, blue: 0.03137254902, alpha: 1)]
    static let spikeColors = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9841352105, green: 0.9841352105, blue: 0.9841352105, alpha: 1), #colorLiteral(red: 0, green: 0.9098039216, blue: 0.2745098039, alpha: 1), #colorLiteral(red: 0.7882352941, green: 0.07843137255, blue: 0.07843137255, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0, green: 0.4039215686, blue: 0.7607843137, alpha: 1), #colorLiteral(red: 1, green: 0, blue: 0.5137254902, alpha: 1), #colorLiteral(red: 1, green: 0.3529411765, blue: 0.1490196078, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)]
}
