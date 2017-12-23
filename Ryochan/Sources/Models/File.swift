//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import Foundation

/// ファイルを扱うクラス
class File {
        
    /// 指定したJSONファイルからデコードしてオブジェクトを生成する
    ///
    /// - Parameters:
    ///   - path: JSONファイルのパス
    ///   - type: 変換する型(Decodableに準拠する必要あり)
    ///   - defaultValue: 変換不可だった場合のデフォルト値
    /// - Returns: 生成されたオブジェクト
    class func decode<T: Decodable>(jsonFilePath path: String, to type: T.Type, defaultValue: T) -> T {
        guard
            let data = try? Data(contentsOf: path.fileURL),
            let ret = try? JSONDecoder().decode(type, from: data)
            else {
                return defaultValue
        }
        return ret
    }
    
    class func deserialize<T>(jsonFilePath path: String, to type: T.Type, defaultValue: T) -> T {
        guard
            let data = try? Data(contentsOf: path.fileURL),
            let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let ret = object as? T
            else {
                return defaultValue
        }
        return ret

    }
    
    /// オブジェクトを変換してJSONの生データを生成する
    ///
    /// - Parameter value: 対象のオブジェクト
    /// - Returns: JSONの生データ
    class func encodedData<T: Encodable>(_ value: T) -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return (try? encoder.encode(value)) ?? Data()
    }
    
    class func cloneData<T: Codable>(_ value: T, type: T.Type) -> T {
        guard
            let data = try? JSONEncoder().encode(value),
            let ret = try? JSONDecoder().decode(type, from: data)
            else {
                fatalError("")
        }
        return ret
    }
    
    /// オブジェクトを変換してJSONの生データを生成する
    ///
    /// - Parameter value: 対象のオブジェクト
    /// - Returns: JSONの生データ
    class func serializedData(_ value: Any) -> Data {
        return try! JSONSerialization.data(withJSONObject: value, options: [.prettyPrinted])
    }
    
    /// オブジェクトを変換してJSONファイルに書き込む
    ///
    /// - Parameters:
    ///   - value: 対象のオブジェクト
    ///   - path: 保存先のJSONファイルのパス
    class func writeEncoded<T: Encodable>(_ value: T, to path: String) {
        let data = encodedData(value)
        try? data.write(to: path.fileURL)
    }
    
    /// オブジェクトを変換してJSONファイルに書き込む
    ///
    /// - Parameters:
    ///   - value: 対象のオブジェクト
    ///   - path: 保存先のJSONファイルのパス
    class func writeSerialized(_ value: Any, to path: String) {
        let data = serializedData(value)
        try? data.write(to: path.fileURL)
    }
    
    class func deleteFile(at path: String) {
        if FileManager.default.fileExists(atPath: path) {
            try? FileManager.default.removeItem(atPath: path)
        }
    }

    /// ファイル(テキストファイル)が存在しない場合は作成する
    /// - Parameter path: ファイル(テキストファイル)のパス
    /// - Returns: 作成した場合にtrueを返す
    class func makeFileIfNeeded(to path: String) -> Bool {
        if !FileManager.default.fileExists(atPath: path) {
            try? "".write(to: path.fileURL, atomically: true, encoding: .utf8)
            return true
        }
        return false
    }
    
    /// ディレクトリが存在しない場合は作成する
    ///
    /// - Parameter path: ディレクトリのパス
    class func makeDirectoryIfNeeded(to path: String) {
        if !FileManager.default.fileExists(atPath: path) {
            try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    /// 指定したディレクトリパス内のファイル名をすべて取得する
    ///
    /// - Parameter directoryPath: ディレクトリパス
    /// - Returns: ファイル名の配列
    class func fileNames(in directoryPath: String) -> [String] {
        return (try? FileManager.default.contentsOfDirectory(atPath: directoryPath)) ?? []
    }
}
