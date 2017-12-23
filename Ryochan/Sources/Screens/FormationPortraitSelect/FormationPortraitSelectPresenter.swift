//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol FormationPortraitSelectPresenterProtocol: class {
    
    var portraits: [Portrait] { get }
    
    var thumbs: [UIImage?] { get }
    
    func loadPortraits()
}

protocol FormationPortraitSelectViewProtocol: class {
    
    func showPortraits()
}

class FormationPortraitSelectPresenter: FormationPortraitSelectPresenterProtocol {
    
    weak var view: FormationPortraitSelectViewProtocol!
    
    private(set) var portraits = [Portrait]()
    private(set) var thumbs = [UIImage?]()
    
    init(view: FormationPortraitSelectViewProtocol) {
        self.view = view
    }
    
    func loadPortraits() {
        portraits = Portrait.list()
        thumbs = Portrait.thumbList()
        view.showPortraits()
    }
}
