import UIKit
import RxSwift
import DesignSystem

class BaseVC: UIViewController {
    let bound = UIScreen.main.bounds
    var disposeBag: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .color(.dittoLettoColor(.bg))
        addView()
        setLayout()
        configureVC()
        bind()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    func addView() {}
    func setLayout() {}
    func configureVC() {}
    func bind() {}
}
