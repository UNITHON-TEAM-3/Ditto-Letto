import UIKit
import DesignSystem
import SnapKit
import Then
import RxCocoa

class OnboardingVC: BaseVC, UIScrollViewDelegate {
    private let onboardingImages: [UIImage] = [.Image.first, .Image.second, .Image.third, .Image.fourth]
    private let xButton = UIButton(type: .system).then {
        $0.setImage(.Image.cancel, for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .clear
    }
    private let scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.bounces = false
        $0.bouncesZoom = false
    }
    override func addView() {
        [
            xButton,
            scrollView
        ].forEach {
            view.addSubview($0)
        }
    }
    override func bind() {
        xButton.rx.tap
            .bind {
                self.navigationController?.pushViewController(MyLetterVC(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    override func configureVC() {
        view.backgroundColor = .color(.dittoLettoColor(.main))
        setupScrollView()
        navigationController?.isNavigationBarHidden = true
    }
    override func setLayout() {
        xButton.snp.makeConstraints {
            $0.width.height.equalTo(UIScreen.main.bounds.width * 0.042)
            $0.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.077)
            $0.right.equalToSuperview().inset(UIScreen.main.bounds.width * 0.061)
        }
        scrollView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.811)
            $0.top.equalTo(xButton.snp.bottom).offset(UIScreen.main.bounds.height * 0.025)
        }
    }
    func setupScrollView() {
        scrollView.delegate = self

        for idx in 0..<onboardingImages.count {
            let onboardingView = UIImageView().then {
                $0.image = onboardingImages[idx]
                $0.contentMode = .scaleAspectFit
            }

            onboardingView.frame = CGRect(
                x: UIScreen.main.bounds.width * CGFloat(idx),
                y: 0,
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height * 0.811
            )
            scrollView.addSubview(onboardingView)
        }
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width * 4,
            height: UIScreen.main.bounds.height * 0.811
        )
    }
}
