//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class PortraitMenuDataSource: MenuViewControllerDataSource, Notificatable {
    
    enum Item: Int {
        case uniformNumber
        case spikeColor
        case playerPosition
        case uniform
        
        static let items: [Item] = [
            .uniformNumber, .spikeColor, .playerPosition, .uniform
        ]
    }
    
    weak var menu: MenuViewController!
    let portrait: Portrait
    
    init(menu: MenuViewController, portrait: Portrait) {
        self.portrait = portrait
        self.menu = menu
    }
    
    func numberOfItems(in menuViewController: MenuViewController) -> Int {
        return Item.items.count
    }
    
    func menuViewController(_ menuViewController: MenuViewController, itemAt index: Int) -> (title: String, type: MenuCellType, value: Any?) {
        switch Item.items[index] {
        case .uniformNumber:
            return (title: "背番号", type: .value, value: portrait.uniformNumber.string)
        case .spikeColor:
            return (title: "スパイクの色", type: .color, value: portrait.spikeColor)
        case .playerPosition:
            return (title: "ポジション", type: .value, value: portrait.goalkeeper ? "ゴールキーパー" : "フィールドプレイヤー")
        case .uniform:
            return (title: "ユニフォーム", type: .image, value: portrait.baseUniform.generateThumbImage())
        }
    }
    
    func menuViewControllerDidTap(at index: Int) {
        switch Item.items[index] {
        case .uniformNumber:  didTapUniformNumberButton()
        case .spikeColor:     didTapSpikeColorButton()
        case .playerPosition: didTapPlayerTypeButton()
        case .uniform:        didTapUniformSelectButton()
        }
    }
    
    private func didTapUniformNumberButton() {
        let candidates = (1...99).map{ $0.string }
        let index = candidates.index(of: portrait.uniformNumber.string)
        
        menu.push(ValueSelectViewController.create(candidates, initial: index) { [unowned self] selected in
            self.portrait.uniformNumber = selected + 1
            self.portrait.save()
            self.menu.reloadData()
        })
    }
    
    private func didTapPlayerTypeButton() {
        portrait.goalkeeper = !portrait.goalkeeper
        portrait.save()
        menu.reloadData()
    }
    
    private func didTapUniformSelectButton() {
        let vc = UniformSelectViewController.create(defaultUniform: portrait.baseUniform) { [unowned self] selectVC, uniform in
            self.portrait.baseUniform = uniform
            selectVC.pop()
            self.menu.reloadData()
        }
        menu.push(vc)
    }
    
    private func didTapSpikeColorButton() {
        ColorSelectViewController.show(from: menu, colors: UIColor.spikeColors, initialColor: portrait.spikeColor) { [unowned self] color in
            self.portrait.spikeColor = color
            self.menu.reloadData()
            self.postNotification(.PortraitDidUpdate)
        }
    }
}
