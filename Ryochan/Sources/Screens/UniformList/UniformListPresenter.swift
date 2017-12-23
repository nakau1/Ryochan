//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol UniformListPresenterProtocol: class {
    
    var uniforms: [Uniform] { get }
    
    var thumbs: [UIImage?] { get }
    
    func loadUniforms()
    
    func addUniform()
    
    func copyUniform(_ uniform: Uniform)
    
    func deleteUniform(_ uniform: Uniform)
    
    func uniformToSelectAfterDeletion(_ uniform: Uniform) -> Uniform
    
    func checkAddableUniform() -> Bool
    
    func checkDeletableUniform() -> Bool
}

protocol UniformListViewProtocol: class {
    
    func showUniforms()
    
    func showErrorDueMinimumNumber()
    
    func showErrorDueLimitedNumber()
}

class UniformListPresenter: UniformListPresenterProtocol, Notificatable {
    
    weak var view: UniformListViewProtocol!
    
    private(set) var uniforms = [Uniform]()
    private(set) var thumbs = [UIImage?]()
    
    init(view: UniformListViewProtocol) {
        self.view = view
        observeNotification(.UniformDidUpdate, when: #selector(loadUniforms))
    }
    
    @objc func loadUniforms() {
        uniforms = Uniform.list()
        thumbs = Uniform.thumbList()
        view.showUniforms()
    }
    
    func copyUniform(_ uniform: Uniform) {
        uniform.copy()
        loadUniforms()
    }
    
    func addUniform() {
        let uniform = Uniform.create()
        uniform.add()
        loadUniforms()
    }
    
    func checkAddableUniform() -> Bool {
        return true // TODO
    }
    
    func deleteUniform(_ uniform: Uniform) {
        uniform.delete()
        loadUniforms()
    }
    
    func uniformToSelectAfterDeletion(_ uniform: Uniform) -> Uniform {
        guard
            let index = uniforms.index(of: uniform),
            uniforms.count > Const.uniformMinimumNumber
            else {
                fatalError("")
        }
        if index == 0 {
            return uniforms[1]
        } else {
            return uniforms[index - 1]
        }
    }
    
    func checkDeletableUniform() -> Bool {
        if uniforms.count <= Const.uniformMinimumNumber {
            view.showErrorDueMinimumNumber()
            return false
        }
        return true
    }
}
