//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class FormationStartingLineupViewController: ViewController, Notificatable {
    
    @IBOutlet private weak var pitchView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var teamNameLabel: UILabel!
    
    private var presenter: FormationStartingLineupPresenterProtocol!
    
    class func create() -> UIViewController {
        let vc = instantiate(self, name: "Formation")
        vc.presenter = FormationStartingLineupPresenter(view: vc)
        return vc.withinNavigation(navigationBarHidden: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeNotification(.PositionTemplateDidSelect, when: #selector(updatePositionsWithFormationStartings))
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        presenter.loadFormation()
    }
    
    @IBAction private func didTapCloseButton() {
        dismiss()
    }
    
    @IBAction private func didTapModeButton() {
        //PositionPortraitListViewController.show(from: self)
    }
    
    @IBAction private func didTapMenuButton() {
        let menu = MenuViewController.create()
        let dataSource = FormationMenuDataSource(menu: menu, formation: presenter.formation)
        menu.show(from: self, dataSource: dataSource)
    }
    
    @IBAction private func didTapTextButton() {
        TextInputViewController.show(from: self, mode: .formationDescription, defaultValue: presenter.formation.title) { [unowned self] text in
            self.presenter.formation.title = text
            self.titleLabel.text = text
            self.presenter.saveFormation()
        }
    }
    
    @IBAction private func didTapNameButton() {
        TextInputViewController.show(from: self, mode: .teamName, defaultValue: presenter.formation.teamName) { [unowned self] text in
            self.presenter.formation.teamName = text
            self.teamNameLabel.text = text
            self.presenter.saveFormation()
        }
    }
    
    private func update(with formation: Formation) {
        titleLabel.text = formation.title
        teamNameLabel.text = formation.teamName
    }
    
    private func updatePositions(_ positions: [Position]) {
        pitchView.subviews.forEach { $0.removeFromSuperview() }
        positions.enumerated().forEach { index, position in
            let positionView = FormationPositionView.create(delegate: self)
            pitchView.addSubview(positionView)
            positionView.index = index
            positionView.set(portrait: position.portrait, uniform: presenter.uniform(at: index))
            positionView.percentage = position.percentage
        }
    }
    
    @objc private func updatePositionsWithFormationStartings() {
        updatePositions(presenter.formation.startings)
    }
    
    private func updatePortrait(portrait: Portrait, at index: Int) {
        let view = positionView(at: index)!
        view.set(portrait: portrait, uniform: presenter.uniform(at: index))
    }

    private func positionView(at index: Int) -> FormationPositionView? {
        return pitchView.viewWithTag(index + 100) as? FormationPositionView
    }
    
    
}

extension FormationStartingLineupViewController: FormationStartingLineupViewProtocol {
    
    func showFormation() {
        update(with: presenter.formation)
        updatePositions(presenter.formation.startings)
    }
}

extension FormationStartingLineupViewController: FormationPositionViewDelegate {
    
    func formationPositionView(_ formationPositionView: FormationPositionView, didTapAt index: Int, portrait: Portrait?) {
        FormationPortraitSelectViewController.show(from: self, portrait: portrait) { [unowned self] selectedPortrait in
            self.presenter.savePosition(at: index, portrait: selectedPortrait)
            self.updatePortrait(portrait: selectedPortrait, at: index)
        }
    }
    
    func formationPositionView(_ formationPositionView: FormationPositionView, didMoveTo percentage: CGPoint, at index: Int, portrait: Portrait?) {
        presenter.savePosition(at: index, percentage: percentage)
    }
}
