import UIKit

class View: UIView {
    // Add stackview with Textfield, Button, Result-Label, put everything in a scrollview?
    init() {
        super.init(frame: .zero)

        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
