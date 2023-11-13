import UIKit
import DesignSystem

class OnboardingImageViewer: UIViewController, UIScrollViewDelegate {
    private let onboardingViews: [(image: UIImage, color: UIColor)] = [
        (.Image.first, .clear),
        (.Image.second, .clear),
        (.Image.third, .clear),
        (.Image.fourth, .clear)
    ]

    let scrollView = UIScrollView()
    let pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .color(.dittoLettoColor(.main))
        setupScrollView()
        setupPageControl()
    }

    func setupScrollView() {
        scrollView.frame = self.view.bounds
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)

        for idx in 0..<onboardingViews.count {
            let imageView = UIImageView()
            imageView.image = onboardingViews[idx].image
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: UIScreen.main.bounds.width * CGFloat(idx),
                                     y: UIScreen.main.bounds.height * 0.137,
                                     width: UIScreen.main.bounds.width,
                                     height: UIScreen.main.bounds.height * 0.811)
            scrollView.addSubview(imageView)
        }

        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(onboardingViews.count), height: scrollView.frame.height)
    }

    func setupPageControl() {
        pageControl.numberOfPages = onboardingViews.count
        pageControl.currentPageIndicatorTintColor = .red // 현재 페이지를 나타내는 표시 색상을 변경합니다. 적절한 색상을 설정해주세요.
        pageControl.pageIndicatorTintColor = .gray // 다른 페이지를 나타내는 표시 색상을 변경합니다. 적절한 색상을 설정해주세요.
        pageControl.center = self.view.center
        self.view.addSubview(pageControl)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
