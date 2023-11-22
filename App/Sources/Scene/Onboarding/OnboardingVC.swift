import UIKit
import DesignSystem
import SnapKit
import Then

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
        $0.backgroundColor = .red
    }
    private let pageControl = UIPageControl()
    override func addView() {
        [
            xButton,
            scrollView
        ].forEach {
            view.addSubview($0)
        }
    }
    override func configureVC() {
        view.backgroundColor = .color(.dittoLettoColor(.main))
        setupScrollView()
        setupPageControl()
    }
    override func setLayout() {
        xButton.snp.makeConstraints {
            $0.width.height.equalTo(UIScreen.main.bounds.width * 0.042)
            $0.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.077)
            $0.right.equalToSuperview().inset(UIScreen.main.bounds.width * 0.061)
        }
        scrollView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height * 0.811)
            $0.centerY.equalToSuperview().offset(UIScreen.main.bounds.height * 0.04)
        }
    }
    func setupScrollView() {
        scrollView.frame = self.view.bounds
        scrollView.delegate = self

        for idx in 0..<onboardingImages.count {
            let onboardingView = UIImageView().then {
                $0.image = onboardingImages[idx]
                $0.contentMode = .scaleAspectFit
            }

            onboardingView.frame = CGRect(
                x: UIScreen.main.bounds.width * CGFloat(idx),
                y: UIScreen.main.bounds.height * 0.025,
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height * 0.811
            )
            scrollView.addSubview(onboardingView)
        }
//        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 4, height: onboardingBackgroundImage.frame.size.height)
    }
    func setupPageControl() {
        pageControl.numberOfPages = onboardingImages.count
        pageControl.currentPageIndicatorTintColor = .clear
        pageControl.pageIndicatorTintColor = .clear
        pageControl.center = self.view.center
        self.view.addSubview(pageControl)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
