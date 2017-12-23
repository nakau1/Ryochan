//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class FormationPortraitSelectViewController: ViewController {
    
    typealias Handler = (Portrait) -> Void
    
    private var presenter: FormationPortraitSelectPresenterProtocol!
    private var selectedPortrait: Portrait?
    private var handler: Handler!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var adapter: PortraitListAdapter!
    
    class func show(from viewController: UIViewController, portrait: Portrait?, handler: @escaping Handler) {
        let vc = create(portrait: portrait, handler: handler)
        let behavior = DialogRiseupBehavior.recommend
        Dialog.show(vc, from: viewController, behavior: behavior)
    }
    
    class func create(portrait: Portrait?, handler: @escaping Handler) -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = FormationPortraitSelectPresenter(view: vc)
        vc.selectedPortrait = portrait
        vc.handler = handler
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.delegate = self
        presenter.loadPortraits()
    }
    
    @IBAction private func didTapCommitButton() {
        if let portrait = selectedPortrait {
            handler(portrait)
        }
        dismiss()
    }
    
    private func update(with portrait: Portrait?) {
        collectionView.reloadData()
    }
}

extension FormationPortraitSelectViewController: FormationPortraitSelectViewProtocol {
    
    func showPortraits() {
        update(with: selectedPortrait)
    }
}

extension FormationPortraitSelectViewController: PortraitListAdapterDelegate {
    
    func numberOfPortraits(in adapter: PortraitListAdapter) -> Int {
        return presenter.portraits.count
    }
    
    func portraitListAdapter(_ adapter: PortraitListAdapter, portraitAt index: Int) -> Portrait {
        return presenter.portraits[index]
    }
    
    func portraitListAdapter(_ adapter: PortraitListAdapter, imageAt index: Int) -> UIImage? {
        return presenter.thumbs[index]
    }
    
    func portraitListAdapterDidSelect(portrait: Portrait) {
        selectedPortrait = portrait
        update(with: selectedPortrait!)
    }
    
    func portraitListAdapterIsSelect(portrait: Portrait) -> Bool {
        return portrait == selectedPortrait
    }
}
