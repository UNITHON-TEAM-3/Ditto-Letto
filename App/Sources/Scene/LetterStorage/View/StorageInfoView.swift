import UIKit
import SnapKit
import DesignSystem

class StorageInfoView: UIView {
    // MARK: - Properties
    private let topStatusBarView: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UIView())
    private let statusBarFirstDetailView: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.gray1))
        return $0
    }(UIView())
    private let statusBarSecondDetailView: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.gray1))
        return $0
    }(UIView())
    private let backgroundWhiteView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    private let fileImageView: UIImageView = {
        $0.image = .Image.redFolder
        return $0
    }(UIImageView())
    private let titleNumberLabel: UILabel = {
        $0.text = "010-1234-5673"
        $0.font = .ramche(.title3)
        return $0
    }(UILabel())
    private let lineView: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.gray2))
        return $0
    }(UIView())
    private let messageImageView: UIImageView = {
        $0.image = .Image.message
        return $0
    }(UIImageView())
    private let messageNumLabel: UILabel = {
        $0.text = "12"
        $0.font = .ramche(.footnote)
        return $0
    }(UILabel())

    // MARK: - Life Cycles
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addView()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set UI
    private func addView() {
        self.addSubview(topStatusBarView)
        self.addSubview(backgroundWhiteView)
        [
            fileImageView,
            titleNumberLabel,
            lineView,
            messageImageView,
            messageNumLabel
        ].forEach {
            backgroundWhiteView.addSubview($0)
        }
        topStatusBarView.addSubview(statusBarFirstDetailView)
        topStatusBarView.addSubview(statusBarSecondDetailView)
    }
    private func setLayout() {
        topStatusBarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.18)
        }
        statusBarFirstDetailView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.65)
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.026)
            make.centerY.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 0.026)
        }
        statusBarSecondDetailView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.3)
            make.trailing.equalTo(statusBarFirstDetailView.snp.leading).inset(-(UIScreen.main.bounds.width * 0.013))
            make.centerY.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 0.026)
        }
        backgroundWhiteView.snp.makeConstraints { make in
            make.top.equalTo(topStatusBarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        fileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width * 0.04)
            make.width.height.equalTo(backgroundWhiteView.snp.height).multipliedBy(0.583)
        }
        titleNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(fileImageView.snp.centerY)
            make.leading.equalTo(fileImageView.snp.trailing).inset(-(UIScreen.main.bounds.width * 0.045))
        }
        messageNumLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().multipliedBy(0.91)
            make.bottom.equalToSuperview().multipliedBy(0.77)
        }
        messageImageView.snp.makeConstraints { make in
            make.centerX.equalTo(messageNumLabel.snp.centerX)
            make.bottom.equalTo(messageNumLabel.snp.top).inset(-(UIScreen.main.bounds.height * 0.009))
            make.width.equalTo(backgroundWhiteView.snp.height).multipliedBy(0.28)
            make.height.equalTo(backgroundWhiteView.snp.height).multipliedBy(0.22)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(topStatusBarView.snp.bottom)
            make.bottom.equalToSuperview()
            make.trailing.equalTo(messageImageView.snp.leading).multipliedBy(0.91)
            make.width.equalTo(0.6)
        }
    }
}
