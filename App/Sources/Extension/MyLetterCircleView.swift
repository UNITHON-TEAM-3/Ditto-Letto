import UIKit
import SnapKit

class MyLetterCircleView: UIView {
    // MARK: - Life Cycles
    init(backgroundColor: String) {
        super.init(frame: .zero)
        self.backgroundColor = DittoLettoAsset.Color.bg.color
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set UI
    private func setView() {
        layer.borderWidth = 0.8
        layer.borderColor = DittoLettoAsset.Color.gray2.color.cgColor
        layer.cornerRadius = 6
    }
}
