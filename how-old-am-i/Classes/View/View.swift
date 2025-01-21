import UIKit

class View: UIView {

    //TODO: Add ScrollView for Keyboard Show/Hide
    private let contentStackView: UIStackView
    let nameTextfield: UITextField
    let guessAgeButton: UIButton
    let resultsLabel: UILabel
    var bottomConstraint: NSLayoutConstraint? = nil

    init() {
        nameTextfield = UITextField()
        nameTextfield.placeholder = "What's your name?"
        nameTextfield.textAlignment = .center

        var buttonConfiguration = UIButton.Configuration.tinted()
        buttonConfiguration.title = "Guess my age!"
        buttonConfiguration.cornerStyle = .capsule
        buttonConfiguration.baseBackgroundColor = .systemBlue
        guessAgeButton = UIButton(configuration: buttonConfiguration)
        guessAgeButton.isEnabled = false
        guessAgeButton.translatesAutoresizingMaskIntoConstraints = false
        resultsLabel = UILabel()

        contentStackView = UIStackView(arrangedSubviews: [resultsLabel, nameTextfield, guessAgeButton])
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.alignment = .center

        super.init(frame: .zero)
        addSubview(contentStackView)

        backgroundColor = .systemBackground

        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupConstraints() {
        let bottomConstraint = safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor)
        let constraints = [
            contentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            bottomConstraint,

            guessAgeButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
        ]

        NSLayoutConstraint.activate(constraints)
        self.bottomConstraint = bottomConstraint
    }
}
