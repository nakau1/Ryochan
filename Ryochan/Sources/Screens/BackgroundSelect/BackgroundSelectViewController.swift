//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class BackgroundSelectViewController: ViewController {
    
    private var presenter: BackgroundSelectPresenterProtocol!
    private var portrait: Portrait!
    private var portraitImage: UIImage?
    private var selectedBackground: Background?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var adapter: BackgroundSelectAdapter!
    @IBOutlet private weak var previewView: UIImageView!
    
    class func show(from viewController: UIViewController, portrait: Portrait, portraitImage: UIImage?) {
        let vc = create(portrait: portrait, portraitImage: portraitImage)
        let behavior = DialogRiseupBehavior.recommend
        Dialog.show(vc, from: viewController, behavior: behavior)
    }
    
    class func create(portrait: Portrait, portraitImage: UIImage?) -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = BackgroundSelectPresenter(view: vc)
        vc.portrait = portrait
        vc.portraitImage = portraitImage
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter.loadBackgrounds()
    }
    
    @IBAction private func didTapSaveButton() {
        
    }
    
    @IBAction private func didTapShareButton() {
        SnsSharing.show(from: self, image: previewView.image!)
    }
    
    func update() {
        if selectedBackground == nil {
            selectedBackground = presenter.backgrounds.first!
        }
        
        previewView.image = BackgroudedImageGenerator().generateImage(
            of: portrait,
            background: selectedBackground!,
            sourceImage: portraitImage
        )
        collectionView.reloadData()
    }
}

extension BackgroundSelectViewController: BackgroundSelectViewProtocol {
    
    func showBackgrounds() {
        update()
    }
}

extension BackgroundSelectViewController: BackgroundSelectAdapterDelegate {
    
    func numberOfBackgrounds(in adapter: BackgroundSelectAdapter) -> Int {
        return presenter.backgrounds.count
    }
    
    func backgroundSelectAdapter(_ adapter: BackgroundSelectAdapter, backgroundAt index: Int) -> Background {
        return presenter.backgrounds[index]
    }
    
    func backgroundSelectAdapter(_ adapter: BackgroundSelectAdapter, imageAt index: Int) -> UIImage? {
        return presenter.thumbs[index]
    }
    
    func backgroundSelectAdapterDidSelect(background: Background) {
        selectedBackground = background
        update()
    }
    
    func backgroundSelectAdapterIsSelect(background: Background) -> Bool {
        return background == selectedBackground
    }
}
