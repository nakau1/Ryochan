//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

enum MenuCellType: String {
    case value
    case color
    case image
}

protocol MenuViewControllerDataSource: class {
    
    func numberOfItems(in menuViewController: MenuViewController) -> Int
    
    func menuViewController(_ menuViewController: MenuViewController, itemAt index: Int) -> (title: String, type: MenuCellType, value: Any?)
    
    func menuViewControllerDidTap(at index: Int)
}

class MenuViewController: ViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var dataSource: MenuViewControllerDataSource!
    
    func show(from viewController: UIViewController, dataSource: MenuViewControllerDataSource) {
        self.dataSource = dataSource
        let dialogBehavior = DialogBehavior.menu
        Dialog.show(self.withinNavigation(navigationBarHidden: true), from: viewController, behavior: dialogBehavior)
    }
    
    class func create() -> MenuViewController {
        return instantiate(self)
    }
    
    @objc private func didNotifyRequestUpdateMenu() {
        tableView.reloadData()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfItems(in: self)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let item = dataSource.menuViewController(self, itemAt: index)
        let cell = tableView.dequeueReusableCell(withIdentifier: item.type.rawValue, for: indexPath)
        
        switch item.type {
        case .value:
            if let value = item.value as? String? {
                (cell as! MenuValueTableViewCell).value = value
            }
        case .color:
            if let value = item.value as? UIColor? {
                (cell as! MenuColorTableViewCell).value = value
            }
        case .image:
            if let value = item.value as? UIImage? {
                (cell as! MenuImageTableViewCell).value = value
            }
        }
        
        (cell as! MenuTableViewCell).name = item.title
        (cell as! MenuTableViewCell).dataSource = dataSource
        (cell as! MenuTableViewCell).tag = index
        return cell
    }
}

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    var dataSource: MenuViewControllerDataSource!
    
    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    @IBAction private func didTapButton() {
        dataSource.menuViewControllerDidTap(at: tag)
    }
}

class MenuValueTableViewCell: MenuTableViewCell {
    
    @IBOutlet private weak var valueLabel: UILabel!
    
    var value: String? = nil {
        didSet {
            valueLabel.text = value
        }
    }
}

class MenuColorTableViewCell: MenuTableViewCell {
    
    @IBOutlet private weak var valueColorView: UIView!
    
    var value: UIColor? = nil {
        didSet {
            valueColorView.backgroundColor = value
        }
    }
}

class MenuImageTableViewCell: MenuTableViewCell {
    
    @IBOutlet private weak var valueImageView: UIImageView!
    
    var value: UIImage? = nil {
        didSet {
            valueImageView.image = value
        }
    }
}
