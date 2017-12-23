//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol TopAdapterDelegate: class {
    
    func numberOfPortraits(in adapter: TopAdapter) -> Int
    
    func topAdapter(_ adapter: TopAdapter, portraitAt index: Int) -> Portrait
    
    func topAdapter(_ adapter: TopAdapter, imageAt index: Int) -> UIImage?
    
    func topAdapterDidSelect(portrait: Portrait)
    
    func topAdapterDidTapAdd()
    
    func topAdapterIsSelect(portrait: Portrait) -> Bool
}

class TopAdapter: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    weak var delegate: TopAdapterDelegate!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate.numberOfPortraits(in: self) + 1 // 1 = Add
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Add", for: indexPath)
            return adapterAddCell(cell)
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            return adapterCell(cell, at: indexPath.row - 1)
        }
    }
    
    private func adapterCell(_ target: UICollectionViewCell, at index: Int) -> TopAdapterCell {
        let cell = target as! TopAdapterCell
        let portrait = delegate.topAdapter(self, portraitAt: index)
        
        cell.delegate = delegate
        cell.choosed = delegate.topAdapterIsSelect(portrait: portrait)
        cell.portrait = portrait
        cell.image = delegate.topAdapter(self, imageAt: index)
        return cell
    }
    
    private func adapterAddCell(_ target: UICollectionViewCell) -> TopAdapterAddCell {
        let cell = target as! TopAdapterAddCell
        cell.delegate = delegate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 8, bottom: 6, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}

/// 似顔絵サムネイルセル
class TopAdapterCell: UICollectionViewCell {
    
    weak var delegate: TopAdapterDelegate!
    
    @IBOutlet private weak var borderedView: RoundedBorderedView!
    @IBOutlet private weak var portraitImageView: UIImageView!
    
    var portrait: Portrait!
    
    var image: UIImage? {
        get {
            return portraitImageView.image
        }
        set {
            portraitImageView.image = newValue
        }
    }
    
    var choosed: Bool = false {
        didSet {
            borderedView.borderColor = choosed ?
                .selectedBorder :
                .normalBorder
            
            borderedView.backgroundColor = choosed ?
                .selectedBackground :
                .normalBackground
        }
    }
    
    @IBAction private func didTapPortraitButton() {
        delegate.topAdapterDidSelect(portrait: portrait)
    }
}

/// 追加用セル
class TopAdapterAddCell: UICollectionViewCell {
    
    weak var delegate: TopAdapterDelegate!
    
    @IBAction private func didTapAddButton() {
        delegate.topAdapterDidTapAdd()
    }
}
