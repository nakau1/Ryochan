//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class UniformListViewController: ViewController, Notificatable {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var adapter: UniformListAdapter!
    
    private var presenter: UniformListPresenterProtocol!
    private var selectedUniform: Uniform?
    
    class func create() -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = UniformListPresenter(view: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        adapter.delegate = self
        presenter.loadUniforms()
    }
    
    @IBAction private func didTapCloseButton() {
        postNotification(.UniformDidUpdate)
        dismiss()
    }
    
    @IBAction private func didTapAddButton() {
        presenter.addUniform()
    }
    
    @IBAction private func didTapEditButton() {
        if let uniform = selectedUniform {
            present(crossDissolve: UniformEditViewController.create(uniform: uniform))
        }
    }
    
    @IBAction private func didTapCopyButton() {
        if let uniform = selectedUniform {
            presenter.copyUniform(uniform)
        }
    }
    
    @IBAction private func didTapDeleteButton() {
        if let uniform = selectedUniform, presenter.checkDeletableUniform() {
            AlertDialog.confirmDelete(from: self) { [unowned self] in
                self.selectedUniform = self.presenter.uniformToSelectAfterDeletion(uniform)
                self.presenter.deleteUniform(uniform)
            }
        }
    }
    
    private func update(with uniform: Uniform) {
        collectionView.reloadData()
    }
}

extension UniformListViewController: UniformListViewProtocol {
    
    func showUniforms() {
        if selectedUniform == nil && presenter.uniforms.count > 0 {
            selectedUniform = presenter.uniforms.first!
        }
        update(with: selectedUniform!)
    }
    
    func showErrorDueMinimumNumber() {
        AlertDialog.showErrorDueMinimumNumber(from: self)
    }
    
    func showErrorDueLimitedNumber() {
        
    }
}

extension UniformListViewController: UniformListAdapterDelegate {
    
    func numberOfUniforms(in adapter: UniformListAdapter) -> Int {
        return presenter.uniforms.count
    }
    
    func uniformListAdapter(_ adapter: UniformListAdapter, imageAt index: Int) -> UIImage? {
        return presenter.thumbs[index]
    }
    
    func uniformListAdapter(_ adapter: UniformListAdapter, uniformAt index: Int) -> Uniform {
        return presenter.uniforms[index]
    }
    
    func uniformListAdapterDidSelect(uniform: Uniform) {
        selectedUniform = uniform
        update(with: selectedUniform!)
    }
    
    func uniformListAdapterIsSelect(uniform: Uniform) -> Bool {
        return uniform == selectedUniform
    }
}
