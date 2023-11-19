import UIKit
import DesignSystem
import SnapKit

final class PhoneBookIndicatorView: UIView {
    // MARK: - UI
    private lazy var trackView = makePhoneBookIndicatorBackView()
    private let trackTintView: UIView = {
        $0.backgroundColor = UIColor.color(.dittoLettoColor(.gray2))
        return $0
    }(UIView())
    // MARK: - Properties
    private var topInsetConstraint: Constraint?
    var heightRatio: Double? {
        didSet {
            guard let heightRatio = heightRatio else { return }
            self.trackTintView.snp.remakeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalToSuperview().multipliedBy(heightRatio)
                $0.top.greaterThanOrEqualToSuperview()
                $0.bottom.lessThanOrEqualToSuperview()
                self.topInsetConstraint = $0.top.equalToSuperview().priority(999).constraint
            }
        }
    }
    var topOffsetRatio: Double? {
        didSet {
            guard let topOffsetRatio = self.topOffsetRatio else { return }
            let topConstraint = topOffsetRatio * self.trackView.bounds.height
            self.topInsetConstraint?.update(inset: topConstraint)
        }
    }
    // MARK: - Initilize
    required init?(coder: NSCoder) {
        fatalError()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
    }

    // MARK: - Set UI
    private func addView() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.color(.dittoLettoColor(.gray2)).cgColor
        self.layer.borderWidth = 0.5
        addSubview(trackView)
        trackView.addSubview(trackTintView)
    }
    private func setLayout() {
        trackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
