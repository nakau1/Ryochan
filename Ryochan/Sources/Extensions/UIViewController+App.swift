//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

// MARK: - Prsentation and Dismisal -
extension UIViewController {
    
    /// モーダルでの画面表示を行う
    /// - Parameters:
    ///   - viewController: 表示するビューコントローラ
    ///   - completion: 表示完了時の処理
    func present(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        present(viewController, animated: true, completion: completion)
    }
    
    /// モーダルでの画面表示を終了する
    /// - Parameter completion: 表示終了時の処理
    func dismiss(completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }
}

// MARK: - CrossDissolve prsentation -
extension UIViewController {
    
    /// クロスディゾルブによる画面遷移を行う
    /// - Parameters:
    ///   - viewController: 遷移先のビューコントローラ
    ///   - completion: 遷移完了時の処理
    func present(crossDissolve viewController: UIViewController, completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true, completion: completion)
    }
}

// MARK: - Navigation -
extension UIViewController {
    
    func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        _ = navigationController?.popViewController(animated: true)
    }
}

// MARK: - Instantiate from storyboard -
extension UIViewController {
    
    /// ストーリーボードからインスタンスを生成する
    /// - Parameters:
    ///   - type: インタンス化する型(原則としてselfを渡す)
    ///   - name: ストーリーボード名(省略した場合はクラス名から"ViewController"を削除した名前)
    ///   - identifier: ストーリーボード上のID(省略した場合はイニシャルビューコントローラを使用する)
    /// - Returns: 生成されたビューコントローラ
    class func instantiate<T: UIViewController>(_ type: T.Type, name: String? = nil, identifier: String? = nil) -> T {
        let className = String(describing: type)
        let storyboardName = name ?? className.replacingOccurrences(of: "ViewController", with: "")
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let identifier = identifier, let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? T {
            return vc
        } else if let vc = storyboard.instantiateInitialViewController() as? T {
            return vc
        } else {
            fatalError("can not instantiate. \(className)")
        }
    }
    
    /// ナビゲーションコントローラの配下に置いた状態で返す
    /// - Parameter navigationBarHidden: ナビゲーションバーを非表示にするかどうか
    /// - Returns: ビューコントローラ(ナビゲーションコントローラ)
    func withinNavigation(navigationBarHidden: Bool = false) -> UIViewController {
        let navi = UINavigationController(rootViewController: self)
        navi.isNavigationBarHidden = navigationBarHidden
        return navi
    }
}
