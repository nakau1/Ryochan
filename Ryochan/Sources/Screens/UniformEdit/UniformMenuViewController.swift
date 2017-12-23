//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class UniformMenuDataSource: MenuViewControllerDataSource, Notificatable {
    
    enum Item: Int {
        case shirtsColor
        case pantsColor
        case numberColor
        case numberPosition
        
        static let items: [Item] = [
            .shirtsColor, .pantsColor, .numberColor, .numberPosition
        ]
    }
    
    weak var menu: MenuViewController!
    let uniform: Uniform
    
    init(menu: MenuViewController, uniform: Uniform) {
        self.uniform = uniform
        self.menu = menu
    }
    
    func numberOfItems(in menuViewController: MenuViewController) -> Int {
        return Item.items.count
    }
    
    func menuViewController(_ menuViewController: MenuViewController, itemAt index: Int) -> (title: String, type: MenuCellType, value: Any?) {
        switch Item.items[index] {
        case .shirtsColor:
            return (title: "シャツの色", type: .color, value: uniform.shirtsColor)
        case .pantsColor:
            return (title: "パンツの色", type: .color, value: uniform.pantsColor)
        case .numberColor:
            return (title: "背番号の色", type: .color, value: uniform.numberColor)
        case .numberPosition:
            return (title: "背番号の位置", type: .value, value: uniform.numberPosition.name)
        }
    }
    
    func menuViewControllerDidTap(at index: Int) {
        switch Item.items[index] {
        case .shirtsColor:    didTapShirtsColorButton()
        case .pantsColor:     didTapPantsColorButton()
        case .numberColor:    didTapNumberColorButton()
        case .numberPosition: didTapNumberPositionButton()
        }
    }
    
    private func didTapShirtsColorButton() {
        ColorSelectViewController.show(from: menu, colors: UIColor.uniformColors, initialColor: uniform.shirtsColor) { [unowned self] color in
            self.uniform.shirtsColor = color
            self.menu.reloadData()
            self.postNotification(.UniformDidUpdate)
        }
    }
    
    private func didTapPantsColorButton() {
        ColorSelectViewController.show(from: menu, colors: UIColor.uniformColors, initialColor: uniform.pantsColor) { [unowned self] color in
            self.uniform.pantsColor = color
            self.menu.reloadData()
            self.postNotification(.UniformDidUpdate)
        }
    }
    
    private func didTapNumberColorButton() {
        ColorSelectViewController.show(from: menu, colors: UIColor.uniformColors, initialColor: uniform.numberColor) { [unowned self] color in
            self.uniform.numberColor = color
            self.menu.reloadData()
            self.postNotification(.UniformDidUpdate)
        }
    }
    
    private func didTapNumberPositionButton() {
        let candidates = UniformNumberPosition.names
        let index = UniformNumberPosition.items.index(of: uniform.numberPosition)
        menu.push(ValueSelectViewController.create(candidates, initial: index) { [unowned self] selected in
            self.uniform.numberPosition = UniformNumberPosition.items[selected]
            self.menu.reloadData()
            self.postNotification(.UniformDidUpdate)
        })
    }
}
