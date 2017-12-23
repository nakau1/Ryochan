//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol PortraitPresenterProtocol: class {
    
    var categoryItems: [Category : [String]] { get }
    
    func loadCategoryItems()
}

protocol PortraitViewProtocol: class {
    
    func showCategoryItems()
}

class PortraitPresenter: PortraitPresenterProtocol {
    
    weak var view: PortraitViewProtocol!
    
    private(set) var categoryItems = [Category : [String]]()
    
    init(view: PortraitViewProtocol) {
        self.view = view
    }
    
    func loadCategoryItems() {
        categoryItems = Category.list()
        view.showCategoryItems()
    }
}
