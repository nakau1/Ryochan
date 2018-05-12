//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol TopPresenterProtocol: class {
    
    var portraits: [Portrait] { get }
    
    var thumbs: [UIImage?] { get }
    
    func loadPortraits()
    
    func addPortrait()
    
    func copyPortrait(_ portrait: Portrait)
    
    func deletePortrait(_ portrait: Portrait)
    
    func portraitToSelectAfterDeletion(_ portrait: Portrait) -> Portrait
    
    func checkAddablePortrait() -> Bool
    
    func checkDeletablePortrait() -> Bool
}

protocol TopViewProtocol: class {
    
    func showPortraits()
    
    func showErrorDueMinimumNumber()
    
    func showErrorDueLimitedNumber()
}

class TopPresenter: TopPresenterProtocol, Notificatable {
    
    weak var view: TopViewProtocol!
    
    private(set) var portraits = [Portrait]()
    private(set) var thumbs = [UIImage?]()
    
    init(view: TopViewProtocol) {
        self.view = view
        observeNotification(.PortraitDidUpdate, when: #selector(loadPortraits))
        observeNotification(.UniformDidUpdate, when: #selector(loadPortraits))
    }
    
    @objc func loadPortraits() {
        portraits = Portrait.list()
        thumbs = Portrait.fullThumbList()
        view.showPortraits()
    }
    
    func copyPortrait(_ portrait: Portrait) {
        portrait.copy()
        loadPortraits()
    }
    
    func addPortrait() {
        let portrait = Portrait.create()
        portrait.add()
        loadPortraits()
    }
    
    func checkAddablePortrait() -> Bool {
        return true // TODO
    }
    
    func deletePortrait(_ portrait: Portrait) {
        portrait.delete()
        loadPortraits()
    }
    
    func portraitToSelectAfterDeletion(_ portrait: Portrait) -> Portrait {
        guard
            let index = portraits.index(of: portrait),
            portraits.count > Const.portraitMinimumNumber
            else {
                fatalError("")
        }
        if index == 0 {
            return portraits[1]
        } else {
            return portraits[index - 1]
        }
    }
    
    func checkDeletablePortrait() -> Bool {
        if portraits.count <= Const.portraitMinimumNumber {
            view.showErrorDueMinimumNumber()
            return false
        }
        return true
    }
}
