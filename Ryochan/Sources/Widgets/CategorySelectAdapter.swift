//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol CategorySelectAdapterDelegate: class {
    
    func categories(in adapter: CategorySelectAdapter) -> [Category]
    
    func categorySelectAdapterDidSelect(category: Category)
    
    func categorySelectAdapter(_ adapter: CategorySelectAdapter, isSelected category: Category) -> Bool
}

class CategorySelectAdapter: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    weak var delegate: CategorySelectAdapterDelegate!
    
    private var categories: [Category] {
        return delegate.categories(in: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategorySelectAdapterCell
        let category = categories[indexPath.row]
        cell.category = category
        cell.choosed = delegate.categorySelectAdapter(self, isSelected: category)
        cell.delegate = delegate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}

class CategorySelectAdapterCell: UICollectionViewCell {
    
    weak var delegate: CategorySelectAdapterDelegate!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var categoryImageView: UIImageView!
    
    var category: Category! {
        didSet {
            nameLabel.text = category.name
        }
    }
    
    var choosed: Bool = false {
        didSet {
            backgroundColor = choosed ?
                .selectedBackground :
                .normalBackground
        }
    }
    
    @IBAction private func didTapCategoryButton() {
        delegate.categorySelectAdapterDidSelect(category: category)
    }
}
