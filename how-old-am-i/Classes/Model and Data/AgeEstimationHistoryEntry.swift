import Foundation

struct AgeEstimationHistoryEntry: Codable, Hashable {
    let date: Date
    let entry: AgeEstimation
}
