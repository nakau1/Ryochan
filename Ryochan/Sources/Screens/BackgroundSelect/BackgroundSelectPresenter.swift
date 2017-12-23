//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol BackgroundSelectPresenterProtocol: class {
    
    var backgrounds: [Background] { get }
    
    var thumbs: [UIImage?] { get }
    
    func loadBackgrounds()
}

protocol BackgroundSelectViewProtocol: class {
    
    func showBackgrounds()
}

class BackgroundSelectPresenter: BackgroundSelectPresenterProtocol {
    
    weak var view: BackgroundSelectViewProtocol!
    
    private(set) var backgrounds = [Background]()
    private(set) var thumbs = [UIImage?]()
    
    init(view: BackgroundSelectViewProtocol) {
        self.view = view
    }
    
    func loadBackgrounds() {
        backgrounds = Background.list()
        thumbs = Background.thumbList()
        view.showBackgrounds()
    }
}
