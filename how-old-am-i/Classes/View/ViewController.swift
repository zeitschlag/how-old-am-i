import UIKit

protocol ViewControllerDelegate: AnyObject {
    func guessAge(_ viewController: ViewController, for name: String)
}

class ViewController: UIViewController {

    weak var delegate: ViewControllerDelegate?
    var contentView: View { view as! View }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() {
        let view = View()
        view.guessAgeButton.addTarget(self, action: #selector(ViewController.guessAge(_:)), for: .touchUpInside)
        view.nameTextfield.addTarget(self, action: #selector(ViewController.textChanged(_:)), for: .editingChanged)
        self.view = view
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        contentView.nameTextfield.becomeFirstResponder()
    }

    // MARK: - Actions

    @objc func guessAge(_ button: UIButton) {

        guard let name = contentView.nameTextfield.text, name.isEmpty == false else { return }

        contentView.nameTextfield.resignFirstResponder()
        contentView.nameTextfield.isEnabled = false
        contentView.guessAgeButton.isEnabled = false
        contentView.guessAgeButton.configuration?.showsActivityIndicator = true
        contentView.guessAgeButton.configuration?.title = ""
        delegate?.guessAge(self, for: name)
    }

    @objc func textChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }

        let buttonEnabled = text.isEmpty == false
        contentView.guessAgeButton.isEnabled = buttonEnabled
    }

    func update(with estimation: AgeEstimation) {
        contentView.guessAgeButton.configuration?.showsActivityIndicator = false
        contentView.guessAgeButton.configuration?.title = "Guess my age!"
        contentView.guessAgeButton.isEnabled = true
        contentView.nameTextfield.isEnabled = true
        contentView.nameTextfield.text = ""

        contentView.resultsLabel.text = "You are \(estimation.age) years old, right?!"
    }

    func update(with error: Error) {
        contentView.guessAgeButton.configuration?.showsActivityIndicator = false
        contentView.guessAgeButton.configuration?.title = "Guess my age!"
        contentView.guessAgeButton.isEnabled = true
        contentView.nameTextfield.isEnabled = true

        contentView.resultsLabel.text = error.localizedDescription
    }
}
