//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class UniformEditViewController: ViewController, Notificatable {
    
    @IBOutlet private weak var previewImageView: UIImageView!
    @IBOutlet private weak var nameButton: UIButton!
    @IBOutlet private weak var colorButton: ColorButton!
    
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    @IBOutlet private weak var categoryAdapter: CategorySelectAdapter!
    
    @IBOutlet private weak var partsCollectionView: UICollectionView!
    @IBOutlet private weak var partsAdapter: PartsSelectAdapter!
    
    private var presenter: UniformEditPresenterProtocol!
    private var uniform: Uniform!
    private var selectedCategory: Category = .sleeve1
    private var selectedPartsIndecies: [Category : Int]!
    
    class func create(uniform: Uniform) -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = UniformEditPresenter(view: vc)
        vc.uniform = uniform
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryAdapter.delegate = self
        partsAdapter.delegate = self
        
        presenter.loadCategoryItems()
        reload()
        
        nameButton.setTitle(uniform.name, for: .normal)
        
        observeNotification(.UniformDidUpdate, when: #selector(reload))
    }
    
    @IBAction private func didTapCloseButton() {
        uniform.save()
        postNotification(.UniformDidUpdate)
        dismiss()
    }
    
    @IBAction private func didTapNameButton() {
        TextInputViewController.show(from: self, mode: .uniformName, defaultValue: uniform.name) { [unowned self] text in
            self.uniform.name = text
            self.nameButton.title = self.uniform.name
        }
    }
    
    @IBAction private func didTapMenuButton() {
        let menu = MenuViewController.create()
        let dataSource = UniformMenuDataSource(menu: menu, uniform: uniform)
        menu.show(from: self, dataSource: dataSource)
    }
    
    @IBAction private func didTapColorButton() {
        let color = selectedCategory.parts(of: uniform).color
        ColorSelectViewController.show(from: self, colors: selectedCategory.colors, initialColor: color) { [unowned self] color in
            self.selectedCategory.parts(of: self.uniform).color = color
            self.reload()
        }
    }
    
    private func prepareSelectedPartsIndecies() {
        selectedPartsIndecies = Category.uniformItems.reduce(into: [Category : Int]()) { res, category in
            let resource = category.parts(of: uniform).resource
            let resources = presenter.categoryItems[category]
            res[category] = resources?.index(of: resource) ?? 0
        }
    }
    
    @objc private func reload() {
        colorButton.color = selectedCategory.parts(of: uniform).color
        previewImageView.image = UniformImageGenerator().generateImage(of: uniform)
    }
}

extension UniformEditViewController: UniformEditViewProtocol {
    
    func showCategoryItems() {
        prepareSelectedPartsIndecies()
        categoryCollectionView.reloadData()
        partsCollectionView.reloadData()
    }
}

extension UniformEditViewController: PartsSelectAdapterDelegate {
    
    func partsSelectAdapterDidSelect(at index: Int) {
        selectedPartsIndecies[selectedCategory] = index
        
        let resource = presenter.categoryItems[selectedCategory]?[index] ?? ""
        uniform.setResource(resource, for: selectedCategory)
        reload()
        
        partsCollectionView.reloadData()
    }
    
    func partsSelectAdapter(_ adapter: PartsSelectAdapter, imageAt index: Int) -> UIImage? {
        guard let items = presenter.categoryItems[selectedCategory] else {
            return nil
        }
        let name = items[index]
        return Path.zipDestination(name).fileImage
    }
    
    func partsSelectAdapter(_ adapter: PartsSelectAdapter, isSelectedAt index: Int) -> Bool {
        let selectedPartsIndex = selectedPartsIndecies[selectedCategory]!
        return selectedPartsIndex == index
    }
    
    func numberOfParts(in adapter: PartsSelectAdapter) -> Int {
        return presenter.categoryItems[selectedCategory]?.count ?? 0
    }
}

extension UniformEditViewController: CategorySelectAdapterDelegate {
    
    func categories(in adapter: CategorySelectAdapter) -> [Category] {
        return Category.uniformItems
    }
    
    func categorySelectAdapterDidSelect(category: Category) {
        selectedCategory = category
        categoryCollectionView.reloadData()
        partsCollectionView.reloadData()
        colorButton.color = category.parts(of: uniform).color
        colorButton.isHidden = !category.hasColor
    }
    
    func categorySelectAdapter(_ adapter: CategorySelectAdapter, isSelected category: Category) -> Bool {
        return category == selectedCategory
    }
}
