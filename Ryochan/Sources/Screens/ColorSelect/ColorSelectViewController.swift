//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class ColorSelectViewController: ViewController {
    
    typealias Handler = (UIColor) -> Void

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var colors: [UIColor]!
    private var selectedColor: UIColor?
    private var handler: Handler!
    
    class func show(from viewController: UIViewController, colors: [UIColor], initialColor: UIColor?, handler: @escaping Handler) {
        let vc = create(colors: colors, initialColor: initialColor, handler: handler)
        let behavior = DialogRiseupBehavior.dialog(height: 168)
        Dialog.show(vc, from: viewController, behavior: behavior)
    }
    
    class func create(colors: [UIColor], initialColor: UIColor?, handler: @escaping Handler) -> UIViewController {
        let vc = instantiate(self)
        vc.colors = colors
        vc.selectedColor = initialColor
        vc.handler = handler
        return vc
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let color = selectedColor, let index = indexOfColors(color) {
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension ColorSelectViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ColorSelectCell
        cell.delegate = self
        cell.color = colors[indexPath.row]
        cell.number = indexPath.row + 1
        cell.choosed = checkColorEquality(cell.color, selectedColor)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    private func checkColorEquality(_ c1: UIColor?, _ c2: UIColor?) -> Bool {
        guard let color1 = c1, let color2 = c2 else {
            return false
        }
        return color1.rgb == color2.rgb
    }
    
    private func indexOfColors(_ color: UIColor?) -> Int? {
        guard let color = color else {
            return nil
        }
        for (index, c) in colors.enumerated() {
            if c.rgb == color.rgb {
                return index
            }
        }
        return nil
    }
}

extension ColorSelectViewController: ColorSelectCellDelegate {
    
    func colorSelectCell(_ cell: ColorSelectCell, didSelect color: UIColor) {
        handler(color)
        dismiss()
    }
}

protocol ColorSelectCellDelegate: class {
    
    func colorSelectCell(_ cell: ColorSelectCell, didSelect color: UIColor)
}

class ColorSelectCell: UICollectionViewCell {
    
    @IBOutlet private weak var colorButton: ColorButton!
    
    weak var delegate: ColorSelectCellDelegate!
    
    var color: UIColor = .clear {
        didSet {
            colorButton.color = color
        }
    }
    
    var choosed = false {
        didSet {
            colorButton.isSelected = choosed
        }
    }
    
    var number = 0 {
        didSet {
            colorButton.textColor = color.isWhiter ? .darkText : .white
            colorButton.text = "\(number)"
        }
    }
    
    @IBAction private func didTapButton() {
        delegate.colorSelectCell(self, didSelect: color)
    }
}
