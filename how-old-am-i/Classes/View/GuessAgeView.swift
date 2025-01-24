import UIKit

class GuessAgeView: UIView {

    //TODO: Add ScrollView for Keyboard Show/Hide
    private let contentStackView: UIStackView
    let nameTextfield: UITextField
    let guessAgeButton: UIButton
    let resultsLabel: UILabel
    var bottomConstraint: NSLayoutConstraint? = nil
    private let margin = 16.0

    init() {
        nameTextfield = UITextField()
        nameTextfield.placeholder = "What's your name?"
        nameTextfield.textAlignment = .center

        var buttonConfiguration = UIButton.Configuration.tinted()
        buttonConfiguration.title = "Guess my age!"
        buttonConfiguration.cornerStyle = .capsule
        buttonConfiguration.baseBackgroundColor = .systemBlue
        guessAgeButton = UIButton(configuration: buttonConfiguration)
        guessAgeButton.translatesAutoresizingMaskIntoConstraints = false
        guessAgeButton.isEnabled = false

        resultsLabel = UILabel()
        resultsLabel.translatesAutoresizingMaskIntoConstraints = false
        resultsLabel.numberOfLines = 0
        resultsLabel.textAlignment = .center
        resultsLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        resultsLabel.adjustsFontForContentSizeCategory = true

        contentStackView = UIStackView(arrangedSubviews: [resultsLabel, nameTextfield, guessAgeButton])
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = margin
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
            contentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: margin),
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: margin),
            bottomConstraint,

            guessAgeButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            resultsLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 500)
        ]

        NSLayoutConstraint.activate(constraints)
        self.bottomConstraint = bottomConstraint
    }
}
