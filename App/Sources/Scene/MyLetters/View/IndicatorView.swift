import UIKit

import SnapKit

final class IndicatorView: UIView {
    // MARK: - UI
    private let triangleView = MyLetterTriangleView()
    private let reverseTriangleView = MyLetterReverseTriangleView()
    private let trackView: UIView = {
        $0.backgroundColor = .lightGray.withAlphaComponent(0.3)
        return $0
    }(UIView())
    private let trackTintView: UIView = {
        $0.backgroundColor = .systemGray2
        return $0
    }(UIView())
    private var topInsetConstraint: Constraint?
    // MARK: - Properties
    var heightRatio: Double? {
        didSet {
            guard let heightRatio = self.heightRatio else { return }
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
            self.topInsetConstraint?.update(inset: topOffsetRatio * self.bounds.height)
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
    override func draw(_ rect: CGRect) {
        triangleView.setNeedsDisplay()
        reverseTriangleView.setNeedsDisplay()
    }
    // MARK: - Set UI
    private func addView() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.color(.dittoLettoColor(.gray2)).cgColor
        self.layer.borderWidth = 0.5
        [triangleView, trackView, reverseTriangleView].forEach {
            addSubview($0)
        }
        trackView.addSubview(trackTintView)
    }
    private func setLayout() {
        triangleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(14)
        }
        reverseTriangleView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(5)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(14)
        }
        trackView.snp.makeConstraints { make in
            make.top.equalTo(triangleView.snp.bottom).inset(-3)
            make.leading.trailing.equalToSuperview().inset(3)
            make.bottom.equalTo(reverseTriangleView.snp.top).inset(-3)
        }
    }
}
