import Foundation

class AgeEstimationStore {

    private static let filename = "history.json"
    private static var storageLocation: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: filename)
    }

    private(set) var history: [AgeEstimationHistoryEntry]
    
    init() {
        history = Self.load()
    }
    
    func add(_ estimation: AgeEstimation) {
        var newHistory = history
        let newEntry = AgeEstimationHistoryEntry(date: Date(), entry: estimation)

        newHistory.append(newEntry)
        Self.store(history: newHistory)
        history = Self.load()
    }
    
    private static func load() -> [AgeEstimationHistoryEntry] {
        guard let storageLocation, let data = try? Data(contentsOf: storageLocation) else { return [] }

        //TODO: Error Handling
        let jsonDecoder = JSONDecoder()
        let history = try? jsonDecoder.decode([AgeEstimationHistoryEntry].self, from: data)
        return history ?? []
    }

    private static func store(history: [AgeEstimationHistoryEntry]) {
        //TODO: Error Handling
        guard let storageLocation else { return }

        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(history)
        try? data?.write(to: storageLocation)
    }
}
