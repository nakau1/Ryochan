//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol UniformSelectPresenterProtocol: class {
    
    var uniforms: [Uniform] { get }
    
    var thumbs: [UIImage?] { get }
    
    func loadUniforms()
}

protocol UniformSelectViewProtocol: class {
    
    func showUniforms()
}

class UniformSelectPresenter: UniformSelectPresenterProtocol {
    
    weak var view: UniformSelectViewProtocol!
    
    private(set) var uniforms = [Uniform]()
    private(set) var thumbs = [UIImage?]()
    
    init(view: UniformSelectViewProtocol) {
        self.view = view
    }
    
    func loadUniforms() {
        uniforms = Uniform.list()
        thumbs = Uniform.thumbList()
        view.showUniforms()
    }
}
