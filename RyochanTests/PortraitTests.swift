//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import XCTest
@testable import Ryochan
/*
class PortraitTests: XCTestCase {
    
    func test_似顔絵のリセット() {
        Portrait.reset()
        XCTAssert(Portrait.list().count == 0, "リセットで空になること")
    }
    
    func test_似顔絵の新規保存() {
        Portrait.reset()
        
        Portrait().add()
        XCTAssert(Portrait.list().count == 1, "追加されていること")
    }
    
    func test_似顔絵の更新() {
        Portrait.reset()
        let b = fixture()[1]
        
        b.name = "Hoge"
        b.save()
        
        XCTAssertEqual(Portrait.list()[1].name, "Hoge", "名前が'Hoge'に変更されて保存されていること")
    }
    
    func test_似顔絵の削除() {
        Portrait.reset()
        let b = fixture()[1]
        
        XCTAssert(Portrait.list().count == 3, "削除するまでは3つの似顔絵があること")
        
        b.delete()
        XCTAssert(Portrait.list().count == 2, "Bを削除すると2つの似顔絵があること")
        
        let csv = Portrait.list().map { $0.id }.joined(separator: ",")
        XCTAssertEqual(csv, "A,C", "Bを削除するとA,Cが残ること")
    }
    
    private func fixture(ids: [String] = ["A", "B", "C"]) -> [Portrait] {
        return ids.reduce(into: [Portrait]()) { res, id in
            let portrait = Portrait()
            portrait.id = id
            portrait.add()
            res.append(portrait)
        }
    }
}
*/
