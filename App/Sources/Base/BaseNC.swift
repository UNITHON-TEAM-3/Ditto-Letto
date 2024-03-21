import UIKit
import DesignSystem

class BaseNC: UINavigationController {
    private var backButtonImage: UIImage? {
        return .Image.backChevron
            .withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: -18, bottom: 0.0, right: 0))
    }

    private var backButtonAppearance: UIBarButtonItemAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.color(.dittoLettoColor(.dark)),
            NSAttributedString.Key.font: UIFont.ramche(.body)
        ]
        backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 30, vertical: 0)
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
        let appearance = UINavigationBarAppearance()
        let appearance2 = UINavigationBarAppearance()
        navigationBar.tintColor = .color(.dittoLettoColor(.dark))
        navigationBar.topItem?.backBarButtonItem?.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.color(.dittoLettoColor(.dark)),
            NSAttributedString.Key.font: UIFont.ramche(.body)
        ], for: .normal)
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance2.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.backgroundColor = .clear

        appearance.configureWithTransparentBackground()
        appearance2.configureWithTransparentBackground()
        appearance.backButtonAppearance = backButtonAppearance
        appearance2.backButtonAppearance = backButtonAppearance
        navigationBar.standardAppearance = appearance2
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
}
