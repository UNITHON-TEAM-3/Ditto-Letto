import UIKit
import DesignSystem
import SnapKit

class PhoneBookTableHeaderView: UIView {
    // MARK: - Properties
    private let addNumberLabel: UILabel = {
        $0.text = "+ 추가하기"
        $0.font = .ramche(.subheadline)
        $0.textColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UILabel())
    private let seperateGrayLine: UILabel = {
        $0.backgroundColor = .color(.dittoLettoColor(.gray1))
        return $0
    }(UILabel())
    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addView()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Set UI
    private func addView() {
        addSubview(addNumberLabel)
        addSubview(seperateGrayLine)
    }
    private func setLayout() {
        addNumberLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        seperateGrayLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(0.6)
        }
    }
}
