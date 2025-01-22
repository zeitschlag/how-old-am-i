import UIKit

class AppCoordinator: NSObject, Coordinator {

    let window: UIWindow
    let pageViewController: UIPageViewController
    let guessAgeViewController: GuessAgeViewController
    let historyViewController: AgeGuessingHistoryViewController
    let apiClient: APIClient
    let store: AgeEstimationStore

    init(window: UIWindow, apiClient: APIClient = APIClient(), store: AgeEstimationStore = AgeEstimationStore()) {
        self.window = window
        self.guessAgeViewController = GuessAgeViewController()
        self.apiClient = apiClient
        self.store = store
        self.historyViewController = AgeGuessingHistoryViewController(history: store.history)
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)

    }

    func start() {
        pageViewController.setViewControllers([guessAgeViewController], direction: .forward, animated: false)
        pageViewController.dataSource = self
        guessAgeViewController.delegate = self
        window.rootViewController = pageViewController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController == guessAgeViewController {
            return historyViewController
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController == historyViewController {
            return guessAgeViewController
        } else {
            return nil
        }
    }
}

extension AppCoordinator: GuessAgeViewControllerDelegate {
    func guessAge(_ viewController: GuessAgeViewController, for name: String) {
        Task {
            try await Task.sleep(for: .seconds(5))
            do {
                let estimation = try await apiClient.getAgeEstimation(for: name)
                store.add(estimation)
                await MainActor.run {
                    historyViewController.update(newHistory: store.history)
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
