//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import Foundation
import SSZipArchive

/// データ移行を行うクラス
class MigrationManager {
    
    /// データ移行の必要性
    var shouldDataMigration: Bool {
        guard let stored = storedVersion else { return true }
        return compareVersion(stored, currentVersion) == .orderedAscending
    }
    
    /// データ移行を実行する
    func migrate() {
        unzip() { [unowned self] in
            File.writeSerialized(self.distribute(), to: Path.partsJsonFile)
            File.writeEncoded(self.distributeBackgrounds(), to: Path.backgroundJsonFile)
            self.storedVersion = self.currentVersion
            print("open " + Path.documentDirectory)
        }
    }
    
    /// 解凍されたZIPファイル内のファイル名を解析して [カテゴリ名 : [名前]] 形式の辞書の形で割り振る
    /// - Returns: [カテゴリ名 : [名前]] 形式の辞書
    func distribute() -> [String : [String]] {
        let ret = Category.items.reduce(into:  [String : [String]]()) { res, category in
            res[category.rawValue] = [String]()
            if category.hasEmpty {
                res[category.rawValue]?.append("empty")
            }
        }
        return File.fileNames(in: Path.zipDestination()).reduce(into: ret) { res, fileName in
            Category.items.forEach { category in
                if !isMatchedName(fileName, for: category) {
                    return
                }
                if isColorMaterialName(fileName, for: category) {
                    return
                }
                res[category.rawValue]!.append(fileName)
            }
        }
    }
    
    /// 解凍されたZIPファイル内のファイル名を解析して背景画像用のリソース名を割り振る
    /// - Returns: リソース名の配列
    func distributeBackgrounds() -> [Background] {
        return File.fileNames(in: Path.zipDestination()).reduce(into: [Background]()) { res, fileName in
            if isBackgroundName(fileName) {
                let background = Background(fileName)
                background.writeImages()
                res.append(background)
            }
        }
    }
    
    /// カテゴリのファイル名に即した名前であるかどうかを返す
    ///
    /// - Parameters:
    ///   - fileName: 対象のファイル名
    ///   - category: カテゴリ
    /// - Returns: カテゴリのファイル名に即した名前であるかどうか
    func isMatchedName(_ fileName: String, for category: Category) -> Bool {
        return fileName.hasPrefix(category.fileBaseName) && fileName.hasSuffix(Const.partsImageExtension)
    }
    
    func isColorMaterialName(_ fileName: String, for category: Category) -> Bool {
        if category.partsColorType != .outlinedColorable {
            return false
        }
        return fileName.removedBackward(Const.partsImageExtension.count).hasSuffix(Const.colorPartsImageSuffix)
    }
    
    func isBackgroundName(_ fileName: String) -> Bool {
        return fileName.hasPrefix(Const.backgroundImagePrefix) && fileName.hasSuffix(Const.backgroundImageExtension)
    }
    
    /// ZIPファイルを解凍する
    /// - Parameter completion: 完了時の処理
    func unzip(completion: @escaping ()->Void) {
        SSZipArchive.unzipFile(
            atPath: Path.zipFile,
            toDestination: Path.documentDirectory,
            progressHandler: { _, _, _, _ in },
            completionHandler: { _, _, _ in completion() }
        )
    }
    
    /// バージョン番号を比較する
    ///
    /// - Parameters:
    ///   - a: 比較対象
    ///   - b: 比較対象
    /// - Returns: 比較結果(aよりbの方が大きい場合に.orderedAscendingを返す)
    func compareVersion(_ a: String, _ b: String) -> ComparisonResult {
        return a.compare(b, options: .numeric, range: nil, locale: nil)
    }
    
    /// アプリ情報から取得した現在のバージョン番号
    var currentVersion: String {
        let dic = Bundle.main.infoDictionary!
        return dic["CFBundleShortVersionString"]! as! String
    }
    
    /// 保存バージョン番号
    var storedVersion: String? {
        get {
            return UserDefaults.standard.string(forKey: Const.storedVersionKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Const.storedVersionKey)
            UserDefaults.standard.synchronize()
        }
    }
}
