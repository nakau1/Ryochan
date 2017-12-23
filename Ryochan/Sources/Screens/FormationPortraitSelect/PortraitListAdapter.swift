//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol PortraitListAdapterDelegate: class {
    
    func numberOfPortraits(in adapter: PortraitListAdapter) -> Int

    func portraitListAdapter(_ adapter: PortraitListAdapter, portraitAt index: Int) -> Portrait

    func portraitListAdapter(_ adapter: PortraitListAdapter, imageAt index: Int) -> UIImage?

    func portraitListAdapterDidSelect(portrait: Portrait)

    func portraitListAdapterIsSelect(portrait: Portrait) -> Bool
}

class PortraitListAdapter: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    weak var delegate: PortraitListAdapterDelegate!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate.numberOfPortraits(in: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PortraitListAdapterCell
        let index = indexPath.row
        let portrait = delegate.portraitListAdapter(self, portraitAt: index)
        
        cell.delegate = delegate
        cell.choosed = delegate.portraitListAdapterIsSelect(portrait: portrait)
        cell.portrait = portrait
        cell.image = delegate.portraitListAdapter(self, imageAt: index)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(collectionView.frame.width - 16, 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
}

class PortraitListAdapterCell: UICollectionViewCell {
    
    weak var delegate: PortraitListAdapterDelegate!
    
    @IBOutlet private weak var maskedView: RoundedBorderedView!
    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var portrait: Portrait! {
        didSet {
            nameLabel.text = portrait.nameWithNumber
        }
    }
    
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
        delegate.portraitListAdapterDidSelect(portrait: portrait)
    }
}
