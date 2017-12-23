//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class PortraitViewController: ViewController, Notificatable {
    
    @IBOutlet private weak var previewView: PortraitPreviewView!
    @IBOutlet private weak var nameButton: UIButton!
    @IBOutlet private weak var colorButton: ColorButton!
    
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    @IBOutlet private weak var categoryAdapter: CategorySelectAdapter!
    
    @IBOutlet private weak var partsCollectionView: UICollectionView!
    @IBOutlet private weak var partsAdapter: PartsSelectAdapter!
    
    private var presenter: PortraitPresenterProtocol!
    private var portrait: Portrait!
    private var selectedCategory: Category = .contour
    private var selectedPartsIndecies: [Category : Int]!
    
    class func create(portrait: Portrait) -> UIViewController {
        let vc = instantiate(self)
        vc.presenter = PortraitPresenter(view: vc)
        vc.portrait = portrait
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryAdapter.delegate = self
        partsAdapter.delegate = self
        previewView.delegate = self
        
        presenter.loadCategoryItems()
        previewView.portrait = portrait
        reload()
        
        nameButton.setTitle(portrait.name, for: .normal)
        
        observeNotification(.PortraitDidUpdate, when: #selector(reload))
    }
    
    @IBAction private func didTapCloseButton() {
        portrait.save()
        postNotification(.PortraitDidUpdate)
        dismiss()
    }
    
    @IBAction private func didTapNameButton() {
        TextInputViewController.show(from: self, mode: .playerName, defaultValue: portrait.name) { [unowned self] text in
            self.portrait.name = text
            self.nameButton.title = self.portrait.name
        }
    }
    
    @IBAction private func didTapMenuButton() {
        let menu = MenuViewController.create()
        let dataSource = PortraitMenuDataSource(menu: menu, portrait: portrait)
        menu.show(from: self, dataSource: dataSource)
    }
    
    @IBAction private func didTapColorButton() {
        let color = selectedCategory.parts(of: portrait).color
        ColorSelectViewController.show(from: self, colors: selectedCategory.colors, initialColor: color) { [unowned self] color in
            self.selectedCategory.parts(of: self.portrait).color = color
            self.reload()
        }
    }
    
    private func prepareSelectedPartsIndecies() {
        selectedPartsIndecies = Category.portraitItems.reduce(into: [Category : Int]()) { res, category in
            let resource = category.parts(of: portrait).resource
            let resources = presenter.categoryItems[category]
            res[category] = resources?.index(of: resource) ?? 0
        }
    }
    
    @objc private func reload() {
        colorButton.color = selectedCategory.parts(of: portrait).color
        previewView.reloadData()
    }
}

extension PortraitViewController: PortraitViewProtocol {
    
    func showCategoryItems() {
        prepareSelectedPartsIndecies()
        categoryCollectionView.reloadData()
        partsCollectionView.reloadData()
    }
}

extension PortraitViewController: PortraitPreviewViewDelegate {
    
    func categoryForPortraitPreviewView(_ previewView: PortraitPreviewView) -> Category {
        return selectedCategory
    }
}

extension PortraitViewController: PartsSelectAdapterDelegate {
    
    func partsSelectAdapterDidSelect(at index: Int) {
        selectedPartsIndecies[selectedCategory] = index
        
        let resource = presenter.categoryItems[selectedCategory]?[index] ?? ""
        portrait.setResource(resource, for: selectedCategory)
        previewView.image = portrait.generateImage()
        
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

extension PortraitViewController: CategorySelectAdapterDelegate {
    
    func categories(in adapter: CategorySelectAdapter) -> [Category] {
        return Category.portraitItems
    }
    
    func categorySelectAdapterDidSelect(category: Category) {
        selectedCategory = category
        categoryCollectionView.reloadData()
        partsCollectionView.reloadData()
        colorButton.color = category.parts(of: portrait).color
        colorButton.isHidden = !category.hasColor
    }
    
    func categorySelectAdapter(_ adapter: CategorySelectAdapter, isSelected category: Category) -> Bool {
        return category == selectedCategory
    }
}
