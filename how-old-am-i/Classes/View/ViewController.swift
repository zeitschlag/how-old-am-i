import UIKit

protocol ViewControllerDelegate: AnyObject {
    // guess-age-button pressed
}

class ViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() {
        let view = View()
        // add target-action to button
        self.view = view
    }

    func update(with estimation: AgeEstimation) {
        // set results-label.text = estimation.age
    }
}
