//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class TextInputViewController: ViewController, UITextFieldDelegate {
    
    typealias CommitHandler = (String) -> Void
    
    private static var instance: TextInputViewController?
    
    @IBOutlet private weak var textField1: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    @IBOutlet private weak var textField2Height: NSLayoutConstraint!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    private var handler: CommitHandler!
    private var mode: TextInputMode!
    
    class func show(from viewController: UIViewController, mode: TextInputMode, defaultValue: String, handler: @escaping CommitHandler) {
        if instance != nil { return }
        
        instance = instantiate(self)
        instance!.mode = mode
        instance!.handler = handler
        instance!.view.translatesAutoresizingMaskIntoConstraints = true
        instance!.view.alpha = 0
        instance!.text = defaultValue
//        instance!.textField.textValue = defaultValue
        
        viewController.view.addSubview(instance!.view)
        
        UIView.animate(
            withDuration: 0.3,
            animations: {
                instance!.view.alpha = 1
            }
        )
    }
    
    private class func close() {
        if instance == nil { return }
        
        instance!.handler(instance!.text)
        UIView.animate(
            withDuration: 0.3,
            animations: {
                instance!.view.alpha = 0
            },
            completion: { _ in
                instance!.view.removeFromSuperview()
                instance = nil
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField1.becomeFirstResponder()
        
        titleLabel.text = mode.title
        descriptionLabel.text = mode.descriptionText
        
        if !mode.isDoubleLine {
            textField2.isHidden = true
            textField2Height.constant = 0
        }
    }
    
    @IBAction private func didTapCloseButton() {
        TextInputViewController.close()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        TextInputViewController.close()
        return true
    }
    
    private var text: String {
        get {
            var ret = textField1.textValue
            if mode.isDoubleLine {
                ret += "\n" + textField2.textValue
            }
            return ret
        }
        set {
            if mode.isDoubleLine {
                let texts = newValue.split(separator: "\n")
                textField1.textValue = String(texts[0])
                textField2.textValue = String(texts[1])
            } else {
                textField1.textValue = newValue
            }
        }
    }
}

enum TextInputMode {
    case playerName
    case uniformName
    case teamName
    case formationDescription
    
    var title: String {
        switch self {
        case .playerName: return "にがおえに\"なまえ\"をつけてください"
        case .uniformName: return "ユニフォームに\"なまえ\"をつけてください"
        case .teamName: return "チーム名"
        case .formationDescription: return ""
        }
    }
    
    var descriptionText: String {
        switch self {
        case .playerName: return ""
        case .uniformName: return "ユニフォーム名"
        case .teamName: return "チーム名"
        case .formationDescription: return ""
        }
    }
    
    var isDoubleLine: Bool {
        switch self {
        case .formationDescription: return true
        default: return false
        }
    }
}
