//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol FormationStartingLineupPresenterProtocol: class {
    
    var formation: Formation { get }
    
    func loadFormation()
    
    func saveFormation()
    
    func savePosition(at index: Int, portrait: Portrait)
    
    func savePosition(at index: Int, percentage: CGPoint)
    
    func uniform(at index: Int) -> Uniform?
}

protocol FormationStartingLineupViewProtocol: class {
    
    func showFormation()
}

class FormationStartingLineupPresenter: FormationStartingLineupPresenterProtocol {
    
    weak var view: FormationStartingLineupViewProtocol!
    
    private(set) var formation = Formation.create()
    
    init(view: FormationStartingLineupViewProtocol) {
        self.view = view
    }
    
    func loadFormation() {
        formation = Formation.load()
        view.showFormation()
    }
    
    func saveFormation() {
        formation.save()
    }
        
    func savePosition(at index: Int, portrait: Portrait) {
        formation.startings[index].portrait = portrait
        formation.save()
    }
    
    func savePosition(at index: Int, percentage: CGPoint) {
        formation.startings[index].percentage = percentage
        formation.save()
    }
    
    func uniform(at index: Int) -> Uniform? {
        return formation.startings[index].goalkeeper ?
            formation.keeperUniform :
            formation.fieldUniform
    }
}
