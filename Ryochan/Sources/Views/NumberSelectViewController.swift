//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class NumberSelectorView: UIControl, UIPickerViewDataSource, UIPickerViewDelegate {
    
    typealias Handler = (Int) -> Void
    
    private var candidateNumbers: [Int]!
    private var selectedIndex = 0
    private var handler: Handler!
    
    class func show(from viewController: UIViewController, candidates: [Int], selected: Int, handler: @escaping Handler) {
        let instance = NumberSelectorView(frame: .zero)
        instance.candidateNumbers = candidates
        instance.selectedIndex = candidates.index(of: selected) ?? 0
        instance.handler = handler
        viewController.view.addSubview(instance)
        instance.becomeFirstResponder()
    }
    
    @objc private func didTapCommitButton() {
        handler(candidateNumbers[selectedIndex])
        resignFirstResponder()
        removeFromSuperview()
    }
    
    override var inputView: UIView? {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
        return pickerView
    }
    
    override var inputAccessoryView: UIView? {
        let bar = UIView(frame: CGRect(CGSize(bounds.width, 64)))
        bar.backgroundColor = #colorLiteral(red: 0.937255, green: 0.937255, blue: 0.956863, alpha: 1)
        
        let commitButton = UIButton(type: .custom)
        commitButton.setTitleColor(.darkGray, for: .normal)
        commitButton.setTitle("OK", for: .normal)
        commitButton.addTarget(self, action: #selector(didTapCommitButton), for: .touchUpInside)
        commitButton.sizeToFit()
        
        commitButton.frame.origin.x = 16
        commitButton.center.y = bar.center.y
        commitButton.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin, .flexibleTopMargin]
        bar.addSubview(commitButton)
        
//        commitButton.centerYAnchor.constraint(equalTo: bar.centerYAnchor).isActive = true
//        commitButton.trailingAnchor.constraint(equalTo: bar.trailingAnchor, constant: 16).isActive = true
        return bar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return candidateNumbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(candidateNumbers[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
