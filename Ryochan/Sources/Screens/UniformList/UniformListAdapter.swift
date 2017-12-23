//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol UniformListAdapterDelegate: class {
    
    func numberOfUniforms(in adapter: UniformListAdapter) -> Int
    
    func uniformListAdapter(_ adapter: UniformListAdapter, imageAt index: Int) -> UIImage?
    
    func uniformListAdapter(_ adapter: UniformListAdapter, uniformAt index: Int) -> Uniform
    
    func uniformListAdapterDidSelect(uniform: Uniform)
    
    func uniformListAdapterIsSelect(uniform: Uniform) -> Bool
}

class UniformListAdapter: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let sideMargin = 8.f
    private let cellInterval = 2.f
    
    weak var delegate: UniformListAdapterDelegate!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate.numberOfUniforms(in: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UniformListAdapterCell
        let uniform = delegate.uniformListAdapter(self, uniformAt: indexPath.row)
        
        cell.delegate = delegate
        cell.choosed = delegate.uniformListAdapterIsSelect(uniform: uniform)
        cell.uniform = uniform
        cell.image = delegate.uniformListAdapter(self, imageAt: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width / 3) - cellInterval
        return CGSize(width, width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellInterval
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class UniformListAdapterCell: UICollectionViewCell {
    
    weak var delegate: UniformListAdapterDelegate!
    
    @IBOutlet private weak var borderedView: RoundedBorderedView!
    @IBOutlet private weak var thumbImageView: UIImageView!
    
    var uniform: Uniform!
    
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
            borderedView.borderColor = choosed ?
                .selectedBorder :
                .normalBorder
            
            borderedView.backgroundColor = choosed ?
                .selectedBackground :
                .normalBackground
        }
    }
    
    @IBAction private func didTapButton() {
        delegate.uniformListAdapterDidSelect(uniform: uniform)
    }
}
