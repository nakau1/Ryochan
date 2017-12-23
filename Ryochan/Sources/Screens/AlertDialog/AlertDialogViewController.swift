//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class AlertDialog {
    
    class func showOK(from viewController: UIViewController, message: String, whenOK: @escaping AlertDialogAction.Handler) {
        let alert = AlertDialogViewController.create(
            message: message,
            left: nil,
            right: AlertDialogAction(title: "OK", style: .default, handler: whenOK)
        )
        Dialog.show(alert, from: viewController, behavior: DialogRiseupBehavior())
    }
    
    class func showYesNo(from viewController: UIViewController, message: String, whenYes: @escaping ()->Void) {
        let alert = AlertDialogViewController.create(
            message: message,
            left: AlertDialogAction(title: "いいえ", style: .cancel) {},
            right: AlertDialogAction(title: "はい", style: .default, handler: whenYes)
        )
        Dialog.show(alert, from: viewController, behavior: DialogRiseupBehavior())
    }
    
    class func showDeleteCancel(from viewController: UIViewController, message: String, whenDelete: @escaping ()->Void) {
        let alert = AlertDialogViewController.create(
            message: message,
            left: AlertDialogAction(title: "キャンセル", style: .cancel) {},
            right: AlertDialogAction(title: "削除する", style: .destructive, handler: whenDelete)
        )
        Dialog.show(alert, from: viewController, behavior: DialogRiseupBehavior())
    }
}

class AlertDialogAction {
    
    typealias Handler = () -> Void
    
    let title: String
    let style: UIAlertActionStyle
    let handler: Handler
    
    init(title: String, style: UIAlertActionStyle, handler: @escaping Handler) {
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    var buttonColor: UIColor {
        switch style {
        case .default:     return #colorLiteral(red: 0.3803921569, green: 0.6431372549, blue: 0.2823529412, alpha: 1)
        case .cancel:      return #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        case .destructive: return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
}

class AlertDialogViewController: UIViewController {
    
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private var leftButton: HighlightButton!
    @IBOutlet private var rightButton: HighlightButton!
    
    private var message: String!
    private var leftAction: AlertDialogAction?
    private var rightAction: AlertDialogAction?
    
    class func create(message: String, left: AlertDialogAction?, right: AlertDialogAction?) -> UIViewController {
        let vc = instantiate(self)
        vc.message = message
        vc.leftAction = left
        vc.rightAction = right
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = message
        setupButton(leftButton, action: leftAction)
        setupButton(rightButton, action: rightAction)
    }
    
    @IBAction private func didTapLeftButton() {
        leftAction!.handler()
        dismiss()
    }
    
    @IBAction private func didTapRightButton() {
        rightAction!.handler()
        dismiss()
    }
    
    private func setupButton(_ button: HighlightButton, action actionOrNil: AlertDialogAction?) {
        if let action = actionOrNil {
            button.title = action.title
            button.normalBackgroundColor = action.buttonColor
            button.tintColor = action.buttonColor.withAlphaComponent(0.7)
        } else {
            button.isHidden = true
        }
    }
}
