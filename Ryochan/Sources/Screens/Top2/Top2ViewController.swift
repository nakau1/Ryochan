//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class Top2ViewController: ViewController {
    
    @IBOutlet private weak var pagingImageView: PagingImageView!
    
    private var presenter: TopPresenterProtocol!
    
    class func create() -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = TopPresenter(view: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pagingImageView.dataSource = self
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        presenter.loadPortraits()
    }
}

extension Top2ViewController: TopViewProtocol {
    
    func showPortraits() {
        pagingImageView.reloadData()
    }
    
    func showErrorDueMinimumNumber() {
        
    }
    
    func showErrorDueLimitedNumber() {
        
    }
}

extension Top2ViewController: PagingImageViewDataSource {
    func pagingImageView(_ pagingImageView: PagingImageView, sizeInContainer rect: CGSize) -> CGSize? {
        return nil
    }
    
    
    func numberOfImages(in pagingImageView: PagingImageView) -> Int {
        return presenter.portraits.count
    }
    
    func pagingImageView(_ pagingImageView: PagingImageView, imageAt index: Int) -> UIImage? {
        return UIImage(named: "sample-portrait")
    }
}
