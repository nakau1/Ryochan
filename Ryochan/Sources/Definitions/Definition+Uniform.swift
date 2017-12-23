//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

extension Const {
    
    /// ユニフォームリスト用のJSONファイル名
    static let uniformsJsonFileName = "uniforms.json"
    
    /// ユニフォーム名のデフォルト値
    static let uniformDefaultName = "ユニフォーム名"
    
    /// ユニフォームの最小数
    static let uniformMinimumNumber = 2
    
    /// ユニフォームの制限数(無料版)
    static let uniformLimitedNumber = 15
}

extension Path {
    
    /// ユニフォーム一覧用のJSONファイルのパス
    static var uniformsJsonFile: String {
        return documentDirectory.path(Const.uniformsJsonFileName)
    }
    
    /// ユニフォームサムネイル用ディレクトリのパス
    static var uniformThumbDirectory: String {
        return Path.documentDirectory.path("UniformThumbs")
    }
    
    /// ユニフォームサムネイル画像ファイルのパス
    /// - Parameter Uniform: ユニフォームオブジェクト
    /// - Returns: ユニフォームサムネイル画像ファイルのパス
    static func uniformThumb(_ uniform: Uniform) -> String {
        return uniformThumbDirectory.path("\(uniform.id).png")
    }
}

extension Notification.Name {
    
    static let UniformDidUpdate = Notification.Name("UniformDidUpdate")
}

extension UIColor {
    
    static let uniformColors = [
        #colorLiteral(red: 0.9841352105, green: 0.9841352105, blue: 0.9841352105, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.137254902, green: 0.09411764706, blue: 0.08235294118, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.1843137255, green: 0.2196078431, blue: 0.3529411765, alpha: 1), #colorLiteral(red: 0.9764705882, green: 0.5725490196, blue: 0.1882352941, alpha: 1),
        #colorLiteral(red: 0, green: 0.1529411765, blue: 0.5411764706, alpha: 1), #colorLiteral(red: 0.7254901961, green: 0, blue: 0.05098039216, alpha: 1), #colorLiteral(red: 1, green: 0, blue: 0.09411764706, alpha: 1), #colorLiteral(red: 1, green: 0.2117647059, blue: 0.1333333333, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.8941176471, blue: 0.2705882353, alpha: 1), #colorLiteral(red: 0, green: 0.07843137255, blue: 0.4901960784, alpha: 1), #colorLiteral(red: 0, green: 0.8509803922, blue: 0.8352941176, alpha: 1),
        #colorLiteral(red: 0, green: 0.2509803922, blue: 0.9176470588, alpha: 1), #colorLiteral(red: 0.2078431373, green: 0.2941176471, blue: 0.8274509804, alpha: 1), #colorLiteral(red: 1, green: 0.3529411765, blue: 0.1490196078, alpha: 1), #colorLiteral(red: 1, green: 0.5058823529, blue: 0.3098039216, alpha: 1), #colorLiteral(red: 0, green: 0.6823529412, blue: 0.7803921569, alpha: 1), #colorLiteral(red: 0.01960784314, green: 0.1921568627, blue: 0.737254902, alpha: 1), #colorLiteral(red: 1, green: 0, blue: 0.5137254902, alpha: 1),
        #colorLiteral(red: 0.6901960784, green: 0.01568627451, blue: 0.09019607843, alpha: 1), #colorLiteral(red: 0.3490196078, green: 0.1647058824, blue: 0.4941176471, alpha: 1), #colorLiteral(red: 0, green: 0.6941176471, blue: 0.8588235294, alpha: 1), #colorLiteral(red: 1, green: 0.2352941176, blue: 0.8392156863, alpha: 1), #colorLiteral(red: 0.9607843137, green: 0.8352941176, blue: 0.2666666667, alpha: 1), #colorLiteral(red: 1, green: 0.7215686275, blue: 0.2745098039, alpha: 1), #colorLiteral(red: 0.9921568627, green: 0.862745098, blue: 0.2823529412, alpha: 1),
        #colorLiteral(red: 0, green: 0.4588235294, blue: 0.1411764706, alpha: 1), #colorLiteral(red: 0, green: 0.568627451, blue: 0.2823529412, alpha: 1), #colorLiteral(red: 0, green: 0.7019607843, blue: 0.8392156863, alpha: 1), #colorLiteral(red: 0, green: 0.9098039216, blue: 0.2745098039, alpha: 1), #colorLiteral(red: 0.4509803922, green: 0.09019607843, blue: 0.6392156863, alpha: 1), #colorLiteral(red: 0, green: 0.4039215686, blue: 0.7607843137, alpha: 1), #colorLiteral(red: 1, green: 0.537254902, blue: 0.2470588235, alpha: 1), #colorLiteral(red: 0.06666666667, green: 0.2901960784, blue: 0.09803921569, alpha: 1),
        #colorLiteral(red: 0.8166625222, green: 0.9034163731, blue: 0.9018172238, alpha: 1), #colorLiteral(red: 1, green: 0.9013400608, blue: 0.9106257021, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.9817401363, blue: 0.8940559471, alpha: 1), #colorLiteral(red: 0.8315532482, green: 0.8087330872, blue: 0.9000137316, alpha: 1), #colorLiteral(red: 0.9170053698, green: 0.8549615083, blue: 0.950413603, alpha: 1), #colorLiteral(red: 1, green: 0.9390080803, blue: 0.9007589103, alpha: 1), #colorLiteral(red: 0.8120917842, green: 0.8987106822, blue: 0.8387437528, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
        ]
}
