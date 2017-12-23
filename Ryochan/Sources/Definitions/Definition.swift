//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// 定数
struct Const {
    
    /// データ移行用のバージョン番号保存キー
    static let storedVersionKey = "Migration.StoredVersion"
}

/// ファイルパス
struct Path {
    
    /// ドキュメントディレクトリ
    static var documentDirectory: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    }
    
    /// ZIPファイルのパス
    static var zipFile: String {
        return Bundle.main.path(forResource: Const.zipFileName, ofType: "zip")!
    }
    
    /// ZIPファイル解凍先のパス
    ///
    /// - Parameter fileName: ファイル名(省略した場合はディレクトリパスが返る)
    /// - Returns: ZIPファイル解凍先のパス
    static func zipDestination(_ fileName: String? = nil) -> String {
        var ret = Path.documentDirectory.path(Const.zipFileName)
        if let fileName = fileName {
            ret = ret.path(fileName)
        }
        return ret
    }
}
