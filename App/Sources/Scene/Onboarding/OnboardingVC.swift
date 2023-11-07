import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class OnboardingVC: BaseVC, UIScrollViewDelegate {
    private let onboardingImages: [(mockUpimage: UIImage, pageImage: UIImage)] = [
        (UIImage(named: "first")!, UIImage(named: "first")!),
        (UIImage(named: "second")!, UIImage(named: "second")!),
        (UIImage(named: "third")!, UIImage(named: "third")!),
        (UIImage(named: "fourth")!, UIImage(named: "fourth")!)
    ].compactMap { $0 as? (mockUpimage: UIImage, pageImage: UIImage) }

    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupPageControl()
    }

    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)

        for i in 0..<onboardingImages.count {
            let imageView = UIImageView()
            imageView.image = onboardingImages[i]
            imageView.contentMode = .scaleAspectFit
            let xPos = view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
        }
        view.addSubview(scrollView)
    }

    private func setupPageControl() {
        pageControl.numberOfPages = onboardingImages.count
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor(named: "placeholderColor")
        view.addSubview(pageControl)

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
}
