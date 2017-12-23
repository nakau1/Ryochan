//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class TopViewController: ViewController {

    @IBOutlet private weak var portraitsCollectionView: UICollectionView!
    @IBOutlet private weak var adapter: TopAdapter!
    @IBOutlet private weak var previewImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    private var presenter: TopPresenterProtocol!
    private var selectedPortrait: Portrait?
    
    class func create() -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = TopPresenter(view: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.delegate = self
        presenter.loadPortraits()
    }
    
    @IBAction private func didTapFormationButton() {
        present(crossDissolve: FormationStartingLineupViewController.create())
    }
    
    @IBAction private func didTapUniformButton() {
        present(crossDissolve: UniformListViewController.create())
    }
    
    @IBAction private func didTapEditButton() {
        if let portrait = selectedPortrait {
            present(crossDissolve: PortraitViewController.create(portrait: portrait))
        }
    }
    
    @IBAction private func didTapCopyButton() {
        if let portrait = selectedPortrait {
            presenter.copyPortrait(portrait)
        }
    }
    
    @IBAction private func didTapDeleteButton() {
        if let portrait = selectedPortrait, presenter.checkDeletablePortrait() {
            AlertDialog.confirmDelete(from: self) { [unowned self] in
                self.selectedPortrait = self.presenter.portraitToSelectAfterDeletion(portrait)
                self.presenter.deletePortrait(portrait)
            }
        }
    }
    
    @IBAction private func didTapSaveButton() {
        if let portrait = selectedPortrait {
            BackgroundSelectViewController.show(from: self, portrait: portrait, portraitImage: previewImageView.image)
        }
    }
    
    private func update(with portrait: Portrait) {
        portraitsCollectionView.reloadData()
        previewImageView.image = FullImageGenerator().generateImage(of: portrait)
        nameLabel.text = portrait.nameWithNumber
    }
}

extension TopViewController: TopViewProtocol {
    
    func showPortraits() {
        if selectedPortrait == nil && presenter.portraits.count > 0 {
            selectedPortrait = presenter.portraits.first!
        }
        update(with: selectedPortrait!)
    }
    
    func showErrorDueMinimumNumber() {
        AlertDialog.showErrorDueMinimumNumber(from: self)
    }
    
    func showErrorDueLimitedNumber() {
        
    }
}

extension TopViewController: TopAdapterDelegate {
    
    func numberOfPortraits(in adapter: TopAdapter) -> Int {
        return presenter.portraits.count
    }
    
    func topAdapter(_ adapter: TopAdapter, portraitAt index: Int) -> Portrait {
        return presenter.portraits[index]
    }
    
    func topAdapter(_ adapter: TopAdapter, imageAt index: Int) -> UIImage? {
        return presenter.thumbs[index]
    }
    
    func topAdapterDidSelect(portrait: Portrait) {
        selectedPortrait = portrait
        update(with: selectedPortrait!)
    }
    
    func topAdapterDidTapAdd() {
        presenter.addPortrait()
    }
    
    func topAdapterIsSelect(portrait: Portrait) -> Bool {
        return portrait == selectedPortrait
    }
}
