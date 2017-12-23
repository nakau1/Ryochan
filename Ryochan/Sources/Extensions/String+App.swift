//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

extension String {
    
    /// パスコンポーネントの追加
    /// NSStringのappendingPathComponentのラッパメソッド
    ///
    /// - Parameter component: 追加するコンポーネント
    /// - Returns: 追加された結果文字列
    func path(_ component: String) -> String {
        return (self as NSString).appendingPathComponent(component)
    }
    
    /// 自身から指定の文字列を削除した文字列を返す
    ///
    /// - Parameter string: 削除したい文字列
    /// - Returns: 削除された文字列
    func removed(_ string: String) -> String {
        return replacingOccurrences(of: string, with: "")
    }
    
    func removedBackward(_ length: Int) -> String {
        return substring(start: 0, end: count - 1 - length)
    }
    
    func substring(start: Int, end: Int) -> String {
        let max = count - 1
        var s = start, e = end
        if max < 0 || e < s || max < s {
            return ""
        } else if s < 0 {
            s = 0
        } else if e < 0 {
            e = 0
        } else if max < e {
            e = max
        }
        let substring = self[index(startIndex, offsetBy: s)...index(startIndex, offsetBy: e)]
        return String(substring)
    }
    
    /*
    public func substring(startIndex start: Int, endIndex end: Int) -> String {
        let max = self.length - 1
        var s = start, e = end
        if max < 0 || e < s || max < s {
            return ""
        } else if s < 0 {
            s = 0
        } else if e < 0 {
            e = 0
        } else if max < e {
            e = max
        }
        return self[self.index(self.startIndex, offsetBy: s)...self.index(self.startIndex, offsetBy: e)]
    }
    */
    
    /// ファイルURL
    var fileURL: URL {
        return URL(fileURLWithPath: self)
    }
    
    /// ファイルから取得した画像
    var fileImage: UIImage? {
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    /// 日付から作成された識別子文字列を返す
    ///
    /// - Returns: 識別子文字列
    static func generateIdentifier() -> String {
        let date = Date()
        let comps: [Calendar.Component] = [.year, .month, .day, .hour, .minute, .second, .nanosecond]
        return comps.reduce(into: "") { res, comp in
            res += "\(Calendar.current.component(comp, from: date))"
        }
    }
}
