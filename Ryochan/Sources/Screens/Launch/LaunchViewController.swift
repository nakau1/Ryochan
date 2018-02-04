//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class LaunchViewController: ViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// データ移行
        let manager = MigrationManager()
        manager.storedVersion = nil // TODO: デバッグのためにnilを代入しているが本来は不要
        if manager.shouldDataMigration {
            manager.migrate()
        }
        
        present(crossDissolve: Top2ViewController.create())
        //present(crossDissolve: TopViewController.create())
    }
}
