//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class UniformSelectViewController: ViewController {
    
    typealias Handler = (UniformSelectViewController, Uniform) -> Void
    
    private var presenter: UniformSelectPresenterProtocol!
    private var selectedUniform: Uniform?
    private var handler: Handler!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var adapter: UniformSelectAdapter!
    
    class func create(defaultUniform: Uniform?, handler: @escaping Handler) -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = UniformSelectPresenter(view: vc)
        vc.selectedUniform = defaultUniform
        vc.handler = handler
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.delegate = self
        presenter.loadUniforms()
    }
}

extension UniformSelectViewController: UniformSelectViewProtocol {
    
    func showUniforms() {
        collectionView.reloadData()
    }
}

extension UniformSelectViewController: UniformSelectAdapterDelegate {
    
    func numberOfUniforms(in adapter: UniformSelectAdapter) -> Int {
        return presenter.uniforms.count
    }
    
    func uniformSelectAdapter(_ adapter: UniformSelectAdapter, uniformAt index: Int) -> Uniform {
        return presenter.uniforms[index]
    }
    
    func uniformSelectAdapter(_ adapter: UniformSelectAdapter, imageAt index: Int) -> UIImage? {
        return presenter.thumbs[index]
    }
    
    func uniformSelectAdapterDidSelect(uniform: Uniform) {
        selectedUniform = uniform
        collectionView.reloadData()
        handler(self, uniform)
    }
    
    func uniformSelectAdapterIsSelect(uniform: Uniform) -> Bool {
        return uniform == selectedUniform
    }
}
