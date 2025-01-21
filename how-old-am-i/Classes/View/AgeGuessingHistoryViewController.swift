import UIKit

class AgeGuessingHistoryViewController: UIViewController {
    // tableView with diffable data source
    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
