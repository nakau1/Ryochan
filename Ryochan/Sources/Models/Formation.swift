//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// フォーメーション
class Formation: Codable {
    
    var teamName = Const.formationTeamDefaultName
    
    var title = Const.formationTitleDefaultText
    
    var startings = [Position]()
    
    var substitutes = [Position]()
    
    var fieldUniform: Uniform?
    
    var keeperUniform: Uniform?
    
    // MARK: - Decodable & Encodable
    
    enum Keys: String, CodingKey {
        case teamName = "team_name"
        case title
        case startings
        case substitutes
        case fieldUniform = "field_uniform"
        case keeperUniform = "keeper_uniform"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        teamName      = container.string(.teamName, Const.formationTeamDefaultName)
        title         = container.string(.title, Const.formationTitleDefaultText)
        startings     = container.to([Position].self, .startings, [])
        substitutes   = container.to([Position].self, .startings, [])
        fieldUniform  = Uniform.search(id: container.string(.fieldUniform)) ?? Uniform.list()[0]
        keeperUniform = Uniform.search(id: container.string(.keeperUniform)) ?? Uniform.list()[1]
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(teamName,          forKey: .teamName)
        try container.encode(title,             forKey: .title)
        try container.encode(startings,         forKey: .startings)
        try container.encode(substitutes,       forKey: .substitutes)
        try container.encode(fieldUniform?.id,  forKey: .fieldUniform)
        try container.encode(keeperUniform?.id, forKey: .keeperUniform)
    }
}

extension Formation {
    
    class func load() -> Formation {
        if File.makeFileIfNeeded(to: Path.formationJsonFile) {
            makeDefaultPosition()
        }
        return File.decode(jsonFilePath: Path.formationJsonFile, to: Formation.self, defaultValue: Formation.create())
    }
    
    func save() {
        File.writeEncoded(self, to: Path.formationJsonFile)
    }
}

private extension Formation {
    
    class func makeDefaultPosition() {
        let formation = Formation.create()
        formation.startings = PositionTemplate.pos442a.positions
        formation.save()
    }
}
