//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol BackgroundSelectAdapterDelegate: class {
    
    func numberOfBackgrounds(in adapter: BackgroundSelectAdapter) -> Int

    func backgroundSelectAdapter(_ adapter: BackgroundSelectAdapter, backgroundAt index: Int) -> Background

    func backgroundSelectAdapter(_ adapter: BackgroundSelectAdapter, imageAt index: Int) -> UIImage?
    
    func backgroundSelectAdapterDidSelect(background: Background)
    
    func backgroundSelectAdapterIsSelect(background: Background) -> Bool
}

class BackgroundSelectAdapter: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    weak var delegate: BackgroundSelectAdapterDelegate!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate.numberOfBackgrounds(in: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BackgroundSelectAdapterCell
        let background = delegate.backgroundSelectAdapter(self, backgroundAt: indexPath.row)
        
        cell.delegate = delegate
        cell.choosed = delegate.backgroundSelectAdapterIsSelect(background: background)
        cell.background = background
        cell.image = delegate.backgroundSelectAdapter(self, imageAt: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let len = collectionView.bounds.height
        return CGSize(len * Const.backgroundRatio, len)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}

class BackgroundSelectAdapterCell: UICollectionViewCell {
    
    weak var delegate: BackgroundSelectAdapterDelegate!
    
    @IBOutlet private weak var maskedView: RoundedBorderedView!
    @IBOutlet private weak var thumbImageView: UIImageView!
    
    var background: Background!
    
    var image: UIImage? {
        get {
            return thumbImageView.image
        }
        set {
            thumbImageView.image = newValue
        }
    }
    
    var choosed: Bool = false {
        didSet {
            maskedView.borderColor = choosed ?
                .selectedBorder :
                .noBorder
            
            maskedView.backgroundColor = choosed ?
                .unmaskedBackground :
                .maskedBackground
        }
    }
    
    @IBAction private func didTapButton() {
        delegate.backgroundSelectAdapterDidSelect(background: background)
    }
}
