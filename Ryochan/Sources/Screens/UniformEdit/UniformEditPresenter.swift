//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol UniformEditPresenterProtocol: class {
    
    var categoryItems: [Category : [String]] { get }
    
    func loadCategoryItems()
}

protocol UniformEditViewProtocol: class {
    
    func showCategoryItems()
}

class UniformEditPresenter: UniformEditPresenterProtocol {
    
    weak var view: UniformEditViewProtocol!
    
    private(set) var categoryItems = [Category : [String]]()
    
    init(view: UniformEditViewProtocol) {
        self.view = view
    }
    
    func loadCategoryItems() {
        categoryItems = Category.list()
        view.showCategoryItems()
    }
}
