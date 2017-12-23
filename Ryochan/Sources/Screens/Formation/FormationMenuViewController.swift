//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class FormationMenuDataSource: MenuViewControllerDataSource, Notificatable {
    
    enum Item: Int {
        case positionTemplate
        
        static let items: [Item] = [
            .positionTemplate
        ]
    }
    
    weak var menu: MenuViewController!
    let formation: Formation
    
    init(menu: MenuViewController, formation: Formation) {
        self.formation = formation
        self.menu = menu
    }
    
    func numberOfItems(in menuViewController: MenuViewController) -> Int {
        return Item.items.count
    }
    
    func menuViewController(_ menuViewController: MenuViewController, itemAt index: Int) -> (title: String, type: MenuCellType, value: Any?) {
        switch Item.items[index] {
        case .positionTemplate:
            return (title: "フォーメーション", type: .value, value: "")
        }
    }
    
    func menuViewControllerDidTap(at index: Int) {
        switch Item.items[index] {
        case .positionTemplate:  didTapPositionTemplateButton()
        }
    }
    
    private func didTapPositionTemplateButton() {
        let candidates = PositionTemplate.items.map { $0.name }
        menu.push(ValueSelectViewController.create(candidates, initial: nil) { [unowned self] selected in
            let template = PositionTemplate.items[selected]
            self.formation.startings = template.applied(to: self.formation.startings)
            self.formation.save()
            self.postNotification(.PositionTemplateDidSelect)
        })
    }
}
