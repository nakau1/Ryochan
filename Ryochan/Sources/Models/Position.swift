//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// フォーメーション内の各ポジション
class Position: Codable {
    
    var percentage: CGPoint = .zero
    
    var portrait: Portrait?
    
    var goalkeeper = false
    
    var captain = false
    
    enum Keys: String, CodingKey {
        case percentage
        case portrait
        case goalkeeper
        case captain
    }
    
    init(_ x: CGFloat, _ y: CGFloat, gk goalkeeper: Bool = false) {
        self.percentage = CGPoint(x, y)
        self.goalkeeper = goalkeeper
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        percentage = container.point(.percentage)
        goalkeeper = container.bool(.goalkeeper)
        captain    = container.bool(.captain)
        portrait   = Portrait.search(id: container.string(.portrait))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(percentage, forKey: .percentage)
        try container.encode(goalkeeper, forKey: .goalkeeper)
        try container.encode(captain, forKey: .captain)
        try container.encode(portrait?.id, forKey: .portrait)
    }
}

struct PositionTemplate {
    
    let name: String
    let positions: [Position]
    
    init(_ name: String, _ positions: [Position]) {
        self.name = name
        self.positions = positions
    }
    
    func applied(to targetPositions: [Position]) -> [Position] {
        return targetPositions.enumerated().map { i, targetPosition in
            targetPosition.percentage = positions[i].percentage
            return targetPosition
        }
    }
}

extension PositionTemplate {
    
    static let items: [PositionTemplate] = [
        .pos442a, .pos442b,
        .pos4231a, .pos4231b,
        .pos4321,
        .pos352a,
        ]
    
    static let pos442a = PositionTemplate("4-4-2 (ボックス型)", [
        Position(0.28, 0.00), Position(0.72, 0.00),
        Position(0.08, 0.28), Position(0.92, 0.28),
        Position(0.32, 0.52), Position(0.68, 0.52),
        Position(0.00, 0.68), Position(1.00, 0.68), Position(0.27, 0.85), Position(0.73, 0.85),
        Position(0.50, 1.00, gk: true),
        ])
    
    static let pos442b = PositionTemplate("4-4-2 (ダイヤ型)", [
        Position(0.28, 0.00), Position(0.72, 0.00),
        Position(0.50, 0.25),
        Position(0.15, 0.35), Position(0.85, 0.35),
        Position(0.50, 0.60),
        Position(0.00, 0.68), Position(1.00, 0.68), Position(0.27, 0.85), Position(0.73, 0.85),
        Position(0.50, 1.00, gk: true),
        ])
    
    static let pos4231a = PositionTemplate("4-2-3-1 ()", [
        Position(0.50, 0.00),
        Position(0.50, 0.30), Position(0.07, 0.33), Position(0.93, 0.33),
        Position(0.28, 0.56), Position(0.72, 0.56),
        Position(0.00, 0.68), Position(1.00, 0.68), Position(0.27, 0.85), Position(0.73, 0.85),
        Position(0.50, 1.00, gk: true),
        ])
    static let pos4231b = PositionTemplate("4-2-3-1 ()", [
        Position(0.50, 0.00),
        Position(0.50, 0.30), Position(0.07, 0.33), Position(0.93, 0.33),
        Position(0.28, 0.56), Position(0.72, 0.56),
        Position(0.00, 0.68), Position(1.00, 0.68), Position(0.27, 0.85), Position(0.73, 0.85),
        Position(0.50, 1.00, gk: true),
        ])
    
    static let pos4321 = PositionTemplate("4-3-2-1", [
        Position(0.50, 0.00),
        Position(0.08, 0.28), Position(0.92, 0.28),
        Position(0.32, 0.52), Position(0.68, 0.52), Position(0.72, 0.00),
        Position(0.00, 0.68), Position(1.00, 0.68), Position(0.27, 0.85), Position(0.73, 0.85),
        Position(0.50, 1.00, gk: true),
        ])
    
    static let pos352a = PositionTemplate("3-5-2 ()", [
        Position(0.28, 0.00), Position(0.72, 0.00),
        Position(0.14, 0.28), Position(0.86, 0.28),
        Position(0.00, 0.55), Position(0.50, 0.45), Position(1.00, 0.55),
        Position(0.20, 0.75), Position(0.80, 0.75), Position(0.50, 0.75, gk: true),
        Position(0.50, 1.00, gk: true),
        ])
}
