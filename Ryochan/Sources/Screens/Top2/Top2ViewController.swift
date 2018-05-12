//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class Top2ViewController: ViewController {
    
    @IBOutlet private weak var topPagedPortraitsView: TopPagedPortraitsView!
    
    private var presenter: TopPresenterProtocol!
    
    class func create() -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = TopPresenter(view: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topPagedPortraitsView.pagingDelegate = self
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        presenter.loadPortraits()
    }
}

extension Top2ViewController: TopViewProtocol {
    
    func showPortraits() {
        topPagedPortraitsView.reloadData()
    }
    
    func showErrorDueMinimumNumber() {
        
    }
    
    func showErrorDueLimitedNumber() {
        
    }
}

extension Top2ViewController: TopPagedPortraitsViewPagingDelegate {
    
    func numberOfImages(in topPagedPortraitsView: TopPagedPortraitsView) -> Int {
        return presenter.portraits.count
    }
    
    func topPagedPortraitsView(_ topPagedPortraitsView: TopPagedPortraitsView, imageAt index: Int) -> UIImage? {
        return presenter.thumbs[index]
    }
    
    func topPagedPortraitsView(_ topPagedPortraitsView: TopPagedPortraitsView, sizeInContainer rect: CGSize) -> CGSize? {
        return nil
    }
    
    func topPagedPortraitsViewDidStartScroll(_ topPagedPortraitsView: TopPagedPortraitsView) {
        
    }
    
    func topPagedPortraitsViewDidEndScroll(_ topPagedPortraitsView: TopPagedPortraitsView, to index: Int) {
        
    }
}
