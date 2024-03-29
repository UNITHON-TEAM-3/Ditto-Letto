import UIKit
import KakaoSDKAuth
import DesignSystem

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScence = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScence)
        window?.windowScene = windowScence

//        UserDefaults().removeObject(forKey: "first")
        print("Token = \(Token.accessToken ?? "NOTHING RECEIVED")")

        if Token.accessToken == nil {
            window?.rootViewController = LoginVC()
        } else {
            if Storage.isFirstTime() {
                window?.rootViewController = UINavigationController(rootViewController: OnboardingVC())
            } else {
                window?.rootViewController = BaseNC(rootViewController: MyLetterVC())
            }
        }

        window?.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if AuthApi.isKakaoTalkLoginUrl(url) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
