//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol UniformSelectAdapterDelegate: class {
    
    func numberOfUniforms(in adapter: UniformSelectAdapter) -> Int

    func uniformSelectAdapter(_ adapter: UniformSelectAdapter, uniformAt index: Int) -> Uniform

    func uniformSelectAdapter(_ adapter: UniformSelectAdapter, imageAt index: Int) -> UIImage?

    func uniformSelectAdapterDidSelect(uniform: Uniform)

    func uniformSelectAdapterIsSelect(uniform: Uniform) -> Bool
}

class UniformSelectAdapter: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    weak var delegate: UniformSelectAdapterDelegate!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate.numberOfUniforms(in: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UniformSelectAdapterCell
        let index = indexPath.row
        let uniform = delegate.uniformSelectAdapter(self, uniformAt: index)
        
        cell.delegate = delegate
        cell.choosed = delegate.uniformSelectAdapterIsSelect(uniform: uniform)
        cell.uniform = uniform
        cell.image = delegate.uniformSelectAdapter(self, imageAt: index)
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

class UniformSelectAdapterCell: UICollectionViewCell {
    
    weak var delegate: UniformSelectAdapterDelegate!
    
    @IBOutlet private weak var maskedView: RoundedBorderedView!
    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var uniform: Uniform! {
        didSet {
            nameLabel.text = uniform.name
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
        delegate.uniformSelectAdapterDidSelect(uniform: uniform)
    }
}
