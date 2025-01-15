import Foundation

class APIClient {
    private let baseURL: URL
    private let session: URLSessionProtocol
    private let jsonDecoder: JSONDecoder

    init(session: URLSessionProtocol = URLSession.shared, baseURL: URL = URL(string: "https://api.agify.io")!, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.baseURL = baseURL
        self.jsonDecoder = jsonDecoder
    }

    func getAgeEstimation(for name: String) async throws -> AgeEstimation {
        let url = baseURL.appending(queryItems: [
            .init(name: "name", value: name)
        ])

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let agifyError = try jsonDecoder.decode(AgifyError.self, from: data)

            throw APIError.client(agifyError.error)
        }

        let ageEstimation = try jsonDecoder.decode(AgeEstimation.self, from: data)
        return ageEstimation
    }
}

enum APIError: Error {
    case client(String)

    var localizedDescription: String {
        switch self {
        case .client(let reason):
            return reason
        }
    }
}
