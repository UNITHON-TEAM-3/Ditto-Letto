import UIKit
import SnapKit

class KeepingLetterView: UIView {
    // MARK: - Properties
    private let topStatusBarView: UIView = {
        $0.backgroundColor = UIColor(named: "dark")
        return $0
    }(UIView())

    private let fileImageView = UIImageView()

    private let titleNumberLabel: UILabel = {
        $0.text = "010-1234-5673"
        $0.font = UIFont(name: "Ramche", size: 20)
        return $0
    }(UILabel())

    private let lineView: UIView = {
        $0.backgroundColor = UIColor(named: "gray2")
        return $0
    }(UIView())

    private let messageImageView: UIImageView = {
        $0.image = UIImage(named: "message")
        return $0
    }(UIImageView())

    private let messageNumLabel: UILabel = {
        $0.text = "12"
        $0.font = UIFont(name: "Ramche", size: 13)
        return $0
    }(UILabel())

    // MARK: - Life Cycles
    init() {
        super.init(frame: .zero)
        setView()
        addView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set UI
    private func setView() {
        addSubview(topStatusBarView)
        addSubview(fileImageView)
        addSubview(titleNumberLabel)
        addSubview(lineView)
        addSubview(messageImageView)
        addSubview(messageNumLabel)
    }

    private func addView() {
        topStatusBarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        fileImageView.snp.makeConstraints { make in
            make.top.equalTo(topStatusBarView.snp.bottom).inset(-12)
            make.leading.equalToSuperview().inset(15)
            make.width.equalTo(45)
            make.height.equalTo(40)
        }
        titleNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(fileImageView.snp.centerY)
            make.leading.equalTo(fileImageView.snp.trailing).inset(-17)
        }
        messageImageView.snp.makeConstraints { make in
            make.top.equalTo(topStatusBarView.snp.bottom).inset(-18)
            make.trailing.equalToSuperview().inset(24)
            make.width.equalTo(20)
            make.height.equalTo(16)
        }
        messageNumLabel.snp.makeConstraints { make in
            make.top.equalTo(messageImageView.snp.bottom).inset(-4)
            make.centerX.equalTo(messageImageView.snp.centerX)
        }
        lineView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(0.6)
        }
    }

    private func setLayout() {
    }
}
