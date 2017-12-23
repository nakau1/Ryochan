//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

@IBDesignable class ColorButton: UIControl {
    
    @IBOutlet private var outlineView: RoundedBorderedView!
    @IBOutlet private var colorView: RoundedBorderedView!
    @IBOutlet private var button: HighlightButton!
    @IBOutlet private var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }
    
    private func loadFromNib() {
        guard let view = Bundle(for: type(of: self)).loadNibNamed("ColorButton", owner: self, options: nil)?.first as? UIView else {
            return
        }
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[view]-0-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["view": view]
        ))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[view]-0-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["view": view]
        ))
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @IBInspectable var color: UIColor = .white {
        didSet {
            if colorView == nil { return }
            colorView.backgroundColor = color
        }
    }
    
    @IBInspectable var textColor: UIColor = .black {
        didSet {
            if textLabel == nil { return }
            textLabel.textColor = textColor
        }
    }
    
    @IBInspectable var text: String = "" {
        didSet {
            if textLabel == nil { return }
            textLabel.text = text
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if outlineView == nil { return }
            outlineView.borderColor = isSelected ?
                .selectedBorder :
                .normalBorder
        }
    }
    
    @objc private func didTapButton() {
        sendActions(for: .touchUpInside)
    }
}
