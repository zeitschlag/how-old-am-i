import UIKit
import SwiftUI

class AgeGuessingHistoryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "AgeGuessingHistoryTableViewCell"

    func update(with entry: AgeEstimationHistoryEntry) {
        contentConfiguration = UIHostingConfiguration(content: {
            Text(entry.entry.displayString)
        })
    }
}
