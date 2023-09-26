import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginVC: BaseVC {
    let viewModel = LoginVM()

    // MARK: - Properties
    private let dittoImageView: UIImageView = {
        $0.image = UIImage(named: "loginImage")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

    private let kakaoButton: UIButton = {
        $0.setImage(UIImage(named: "kakaoButton"), for: .normal)
        return $0
    }(UIButton())

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Set UI
    override func addView() {
        view.addSubview(dittoImageView)
        view.addSubview(kakaoButton)
    }

    override func setLayout() {
        dittoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(178)
            make.bottom.equalToSuperview().inset(310)
            make.horizontalEdges.equalToSuperview().inset(22)
        }
        kakaoButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(78)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }

    override func bind() {
        let input = LoginVM.Input(loginButtonTapped: kakaoButton.rx.tap.asObservable())
        let output = viewModel.transform(input)

        viewModel.result
            .bind { [weak self] bool in
                if bool {
                    let homeVC = MyLetterVC()
                    let navi = BaseNC(rootViewController: homeVC)
                    navi.modalPresentationStyle = .overFullScreen
                    self?.present(navi, animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
}
