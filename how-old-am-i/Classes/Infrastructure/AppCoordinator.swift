import UIKit

class AppCoordinator: Coordinator {

    let window: UIWindow
    let viewController: ViewController
    let apiClient: APIClient

    init(window: UIWindow, apiClient: APIClient = APIClient()) {
        self.window = window
        self.viewController = ViewController()
        self.apiClient = apiClient
    }

    func start() {
        viewController.delegate = self
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: ViewControllerDelegate {
    func guessAge(_ viewController: ViewController, for name: String) {
        Task {
            try await Task.sleep(for: .seconds(5))
            do {
                let estimation = try await apiClient.getAgeEstimation(for: name)
                await MainActor.run {
                    viewController.update(with: estimation)
                }
            } catch {
                await MainActor.run {
                    viewController.update(with: error)
                }
            }
        }
    }
}
