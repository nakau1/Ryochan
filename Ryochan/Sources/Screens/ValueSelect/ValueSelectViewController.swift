//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

class ValueSelectViewController: ViewController {
    
    typealias Handler = (Int) -> Void

    @IBOutlet private weak var tableView: UITableView!
    
    private var candidates: [String]!
    private var selectedIndex: Int?
    private var handler: Handler!
    
    class func show(from viewController: UIViewController, candidates: [String], initial index: Int?, handler: @escaping Handler) {
        let vc = create(candidates, initial: index, handler: handler)
        let behavior = DialogRiseupBehavior.dialog(height: 340)
        Dialog.show(vc, from: viewController, behavior: behavior)
    }
    
    class func create(_ candidates: [String], initial index: Int?, handler: @escaping Handler) -> UIViewController {
        let vc = instantiate(self)
        vc.candidates = candidates
        vc.selectedIndex = index
        vc.handler = handler
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = selectedIndex {
            let indexPath = IndexPath(item: index, section: 0)
            tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction private func didTapBackButton() {
        if let _ = navigationController {
            pop()
        } else {
            dismiss()
        }
    }
}

extension ValueSelectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = candidates[indexPath.row]
        cell.accessoryType = (selectedIndex == indexPath.row) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        handler(indexPath.row)
        didTapBackButton()
    }
}
