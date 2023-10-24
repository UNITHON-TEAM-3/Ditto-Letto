import UIKit

class BaseNC: UINavigationController {
    private var backButtonImage: UIImage? {
        return DittoLettoAsset.Image.backChevron.image
            .withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: 30, bottom: 0.0, right: 0.0))
    }

    private var backButtonAppearance: UIBarButtonItemAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        return backButtonAppearance
    }

    static func makeNavigationController(rootViewController: UIViewController) -> BaseNC {
        let navigationController = BaseNC(rootViewController: rootViewController)
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearance()
    }

    func setNavigationBarAppearance() {
        backButtonImage?.draw(in: CGRect(x: 40, y: 0, width: 8, height: 16))
        let appearance = UINavigationBarAppearance()
        let appearance2 = UINavigationBarAppearance()
        navigationBar.tintColor = .clear
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance2.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.backgroundColor = .clear

        appearance.configureWithTransparentBackground()
        appearance2.configureWithDefaultBackground()
        appearance.backButtonAppearance = backButtonAppearance
        appearance2.backButtonAppearance = backButtonAppearance
        navigationBar.standardAppearance = appearance2
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.backItem?.title = nil
    }
}
