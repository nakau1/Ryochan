//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol PartsSelectAdapterDelegate: class {
    
    func partsSelectAdapterDidSelect(at index: Int)
    
    func partsSelectAdapter(_ adapter: PartsSelectAdapter, imageAt index: Int) -> UIImage?
    
    func partsSelectAdapter(_ adapter: PartsSelectAdapter, isSelectedAt index: Int) -> Bool
    
    func numberOfParts(in adapter: PartsSelectAdapter) -> Int
}

class PartsSelectAdapter: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    weak var delegate: PartsSelectAdapterDelegate!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate.numberOfParts(in: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PartsSelectAdapterCell
        let index = indexPath.row
        cell.index = index
        cell.image = delegate.partsSelectAdapter(self, imageAt: index)
        cell.choosed = delegate.partsSelectAdapter(self, isSelectedAt: index)
        cell.delegate = delegate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}

class PartsSelectAdapterCell: UICollectionViewCell {
    
    @IBOutlet private weak var borderedView: RoundedBorderedView!
    @IBOutlet private weak var partsImageView: UIImageView!
    @IBOutlet private weak var emptyLabel: UILabel!
    
    weak var delegate: PartsSelectAdapterDelegate!
    
    var index = 0
    
    var image: UIImage? {
        didSet {
            partsImageView.image = image
            emptyLabel.isHidden = (image != nil)
        }
    }
    
    var choosed: Bool = false {
        didSet {
            backgroundColor = choosed ?
                .selectedBackground :
                .normalBackground
            
            borderedView.borderWidth = choosed ? 3 : 0
        }
    }
    
    @IBAction private func didTapPartsButton() {
        delegate.partsSelectAdapterDidSelect(at: index)
    }
}
