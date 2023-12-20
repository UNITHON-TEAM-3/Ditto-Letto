import UIKit
import DesignSystem
import SnapKit

final class SetCharacterAndNameView: UIView {
    // MARK: - Properties
    private let topBarView: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.third))
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 0.8
        return $0
    }(UIView())
    private let topBarDetailView: UIView = {
        $0.backgroundColor = .black
        return $0
    }(UIView())
    private let bodyView: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.gray1))
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 0.8
        return $0
    }(UIView())
    // MARK: - Life Cycles
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        addView()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Set UI
    private func addView() {
        [
            topBarView, bodyView
        ].forEach {
            addSubview($0)
        }
        topBarView.addSubview(topBarDetailView)
    }
    private func setLayout() {
        topBarView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        topBarDetailView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.032)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        bodyView.snp.makeConstraints { make in
            make.top.equalTo(topBarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
