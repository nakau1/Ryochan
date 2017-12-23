//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import XCTest
@testable import Ryochan

/*
 - [ ] 現在のバージョンを取得する
 - [ ] バージョンを保存する
 - [ ] 保存したバージョンと比較する
 - [ ] 比較対象がない場合はデータ移行が必要
 - [ ] 現在バージョンのほうが大きければデータ移行が必要
 - [ ] データ移行の実行
 */
class PartsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
//    func test_MovableTypeの比較() {
//        let a = MovableType.vertically(area: 100)
//        let b = MovableType.vertically(area: 50)
//        let c = MovableType.freely
//        XCTAssertEqual(a, b, "同じMovableTypeであれば等価とされること")
//        XCTAssertNotEqual(a, c, "違うMovableTypeであれば非等価とされること")
//    }
    
    func test_String_substringテスト() {
        let a = "abcde.png".removedBackward(4)
        XCTAssertEqual(a, "abcde", "後方の4文字が削除されていること")
        
        let b = "png".removedBackward(4)
        XCTAssertEqual(b, "", "空文字が帰ること")
        
    }
}
