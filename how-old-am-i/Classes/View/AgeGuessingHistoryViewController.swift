import UIKit

enum AgeGuessList {
    enum Section: Hashable {
        case main
    }

    enum Item: Hashable {
        case entry(AgeEstimationHistoryEntry)
    }
}

class AgeGuessingHistoryViewController: UIViewController {
    private(set) var history: [AgeEstimationHistoryEntry]
    let tableView: UITableView
    private var dataSource: UITableViewDiffableDataSource<AgeGuessList.Section, AgeGuessList.Item>?

    init(history: [AgeEstimationHistoryEntry]) {
        self.history = history
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AgeGuessingHistoryTableViewCell.self, forCellReuseIdentifier: AgeGuessingHistoryTableViewCell.reuseIdentifier)
        
        super.init(nibName: nil, bundle: nil)

        let dataSource = UITableViewDiffableDataSource<AgeGuessList.Section, AgeGuessList.Item>(tableView: tableView) { [weak self] tableView, indexPath, itemIdentifier in
            guard let self else { fatalError("where self???") }

            let entry = self.history[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: AgeGuessingHistoryTableViewCell.reuseIdentifier, for: indexPath) as! AgeGuessingHistoryTableViewCell

            cell.update(with: entry)
            return cell
        }

        tableView.dataSource = dataSource
        tableView.delegate = self
        self.dataSource = dataSource
        view.addSubview(tableView)
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupConstraints() {
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update(newHistory: history)
    }

    func update(newHistory: [AgeEstimationHistoryEntry]) {
        history = newHistory

        var snapshot = NSDiffableDataSourceSnapshot<AgeGuessList.Section, AgeGuessList.Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(newHistory.map { .entry($0) } )

        dataSource?.apply(snapshot)
    }
}

extension AgeGuessingHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
