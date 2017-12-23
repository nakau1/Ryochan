//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol Notificatable {}

extension Notificatable {
    
    func observeNotification(_ name: Notification.Name, when selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    func postNotification(_ name: Notification.Name) {
        NotificationCenter.default.post(name: name, object: nil)
    }
}
