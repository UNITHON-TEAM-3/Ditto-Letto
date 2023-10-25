import UIKit
import SnapKit

class StorageInfoView: UIView {
    // MARK: - Properties
    private let topStatusBarView: UIView = {
        $0.backgroundColor = DittoLettoAsset.Color.dark.color
        return $0
    }(UIView())
    private let statusBarFirstDetailView: UIView = {
        $0.backgroundColor = DittoLettoAsset.Color.gray1.color
        return $0
    }(UIView())
    private let statusBarSecondDetailView: UIView = {
        $0.backgroundColor = DittoLettoAsset.Color.gray1.color
        return $0
    }(UIView())
    private let fileImageView: UIImageView = {
        $0.image = UIImage(named: "redFolder")
        return $0
    }(UIImageView())
    private let titleNumberLabel: UILabel = {
        $0.text = "010-1234-5673"
        $0.font = DittoLettoFontFamily.Ramche.regular.font(size: 20)
        return $0
    }(UILabel())
    private let lineView: UIView = {
        $0.backgroundColor = DittoLettoAsset.Color.gray2.color
        return $0
    }(UIView())
    private let messageImageView: UIImageView = {
        $0.image = DittoLettoAsset.Image.message.image
        return $0
    }(UIImageView())
    private let messageNumLabel: UILabel = {
        $0.text = "12"
        $0.font = DittoLettoFontFamily.Ramche.regular.font(size: 13)
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
        [
            topStatusBarView,
            fileImageView,
            titleNumberLabel,
            lineView,
            messageImageView,
            messageNumLabel
        ].forEach {
            self.addSubview($0)
        }
        topStatusBarView.addSubview(statusBarFirstDetailView)
        topStatusBarView.addSubview(statusBarSecondDetailView)
    }
    private func setLayout() {
        topStatusBarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(16)
        }
        statusBarFirstDetailView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(3)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(10)
        }
        statusBarSecondDetailView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.trailing.equalTo(statusBarFirstDetailView.snp.leading).inset(-5)
            make.centerY.equalToSuperview()
            make.width.equalTo(10)
        }
        fileImageView.snp.makeConstraints { make in
            make.top.equalTo(topStatusBarView.snp.bottom).inset(-14)
            make.leading.equalToSuperview().inset(15)
            make.width.equalTo(45)
            make.height.equalTo(40)
        }
        titleNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(fileImageView.snp.centerY)
            make.leading.equalTo(fileImageView.snp.trailing).inset(-17)
        }
        messageImageView.snp.makeConstraints { make in
            make.top.equalTo(topStatusBarView.snp.bottom).inset(-20)
            make.trailing.equalToSuperview().inset(24)
            make.width.equalTo(20)
            make.height.equalTo(16)
        }
        messageNumLabel.snp.makeConstraints { make in
            make.top.equalTo(messageImageView.snp.bottom).inset(-4)
            make.centerX.equalTo(messageImageView.snp.centerX)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(topStatusBarView.snp.bottom)
            make.bottom.equalToSuperview()
            make.trailing.equalTo(messageImageView.snp.leading).inset(-24)
            make.width.equalTo(0.6)
        }
    }
}
