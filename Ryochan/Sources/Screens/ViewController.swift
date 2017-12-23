//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var isLayouted = false
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isLayouted {
            viewDidLayout()
            isLayouted = true
        }
    }
    
    func viewDidLayout() {
        // NOP.
    }
}
