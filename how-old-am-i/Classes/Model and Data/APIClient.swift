import Foundation

class APIClient {

    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func getAgeEstimation(for name: String) async throws -> AgeEstimation {
        // GET-request to https://api.agify.io?name=\(name)
        // check for error and decode data into an AgeEstimation
        fatalError("Not implemented yet")
    }
}
