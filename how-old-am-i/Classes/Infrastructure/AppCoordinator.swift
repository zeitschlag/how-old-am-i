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
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: ViewControllerDelegate {
    // call APIClient, update viewController with result
}
