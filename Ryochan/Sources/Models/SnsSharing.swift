//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class SnsSharing {
    
    class func show(from viewController: UIViewController, items: [Any]) {
        let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        viewController.present(vc, animated: true, completion: nil)
    }
    
    class func show(from viewController: UIViewController, image: UIImage) {
        show(from: viewController, items: [" #似顔絵アプリ", image])
    }
}
