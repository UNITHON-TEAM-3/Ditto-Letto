import UIKit
import SnapKit
import DesignSystem

class MyLetterCircleView: UIView {
    // MARK: - Life Cycles
    init(backgroundColor: String) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(named: "\(backgroundColor)")
        setView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set UI
    private func setView() {
        layer.borderWidth = 0.8
        layer.borderColor = UIColor.color(.dittoLettoColor(.gray2)).cgColor
        layer.cornerRadius = 6
    }
}
