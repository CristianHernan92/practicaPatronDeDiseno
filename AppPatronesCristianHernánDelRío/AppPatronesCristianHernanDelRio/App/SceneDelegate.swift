import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let scene = (scene as? UIWindowScene) else {
                return
            }
            let window = UIWindow(windowScene: scene)
            let loginViewController = Login()
            loginViewController.viewModel = LoginViewModel(viewController: loginViewController)
            let navigationController = UINavigationController(rootViewController: loginViewController)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            self.window = window
        }
}

