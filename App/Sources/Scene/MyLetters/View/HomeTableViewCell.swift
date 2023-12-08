import UIKit
import DesignSystem
import SnapKit

protocol HomeTableViewCellDelegate: AnyObject {
    func replyButtonTap()
}

class HomeTableViewCell: BaseTC {
    static let identifier = "HomeTableViewCell"
    weak var delegate: HomeTableViewCellDelegate?
    // MARK: - Properties
    private let titleImageView = UIImageView()
    private let titleLabel: UILabel = {
        $0.text = "010-2326-3046"
        $0.font = .ramche(.body)
        return $0
    }(UILabel())
    private let subTitleLabel: UILabel = {
        $0.text = "subTitle"
        $0.font = .ramche(.footnote)
        return $0
    }(UILabel())
    private let transportationImageView = UIImageView()
    private let transportationState = UIImageView()
    private let replyButton: UIButton = {
        $0.setImage(.Image.replyButton, for: .normal)
        $0.addTarget(self, action: #selector(replyButtonTap), for: .touchUpInside)
        return $0
    }(UIButton())
    var type: HomeCellType? {
        didSet {
            setLayout(type: type)
        }
    }
    var model: BoxLetterData? {
        didSet {
            configureVC()
        }
    }

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    override func addView() {
        [
            titleImageView,
            titleLabel,
            subTitleLabel,
            transportationImageView,
            transportationState,
            replyButton
        ].forEach {
            contentView.addSubview($0)
        }
        setLayout(type: .sendingFriend)
    }
    func setLayout(type: HomeCellType?) {
        guard let type = type else { return }
        switch type {
        case .stranger:
            setStrangerUI()
        case .friend:
            setFriendUI()
        case .sendingStranger:
            setSendingStrangerUI()
        case.sendingFriend:
            setSendingFriendUI()
        case .waiting:
            setWaitingUI()
        }
    }
    override func configureVC() {
        guard let model = model else { return }
        titleLabel.text = model.phoneNumber
        if model.type == MessageType.normal.rawValue {
            titleImageView.image = .Image.redFolder
        }
        if model.type == MessageType.password.rawValue {
            titleImageView.image = .Image.yellowFolder
        }

        // 도착 완료 시
        if model.arrived {
            transportationImageView.image = nil
            transportationState.image = nil
        } else {
            // 도착까지 시간이 남았을 시
            self.setImageForProgress(model.progressLevel, transportationState)
            self.setImageForTransportation(model.mediumType, transportationImageView)
        }
        // 임시
        transportationState.image = .Image.state7
        transportationImageView.image = .Image.airplaneIcon
    }
    @objc private func replyButtonTap() {
        delegate?.replyButtonTap()
    }
}

extension HomeTableViewCell {
    private func setStrangerUI() {
        titleImageView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width * 0.133)
            make.height.equalTo(UIScreen.main.bounds.width * 0.112)
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.025)
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 0.0297).priority(.low)
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width * 0.053)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleImageView.snp.centerY)
            make.centerX.equalToSuperview()
        }
        replyButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.042)
            make.width.equalTo(UIScreen.main.bounds.width * 0.109)
            make.height.equalTo(UIScreen.main.bounds.width * 0.117)
        }
    }
    private func setFriendUI() {
        titleImageView.snp.makeConstraints { make in
            make.width.height.equalTo(UIScreen.main.bounds.width * 0.133)
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.021)
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 0.026).priority(.low)
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width * 0.053)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.top).inset(UIScreen.main.bounds.height * 0.003)
            make.leading.equalTo(titleImageView.snp.trailing).offset(UIScreen.main.bounds.width * 0.048)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(titleImageView.snp.bottom).inset(UIScreen.main.bounds.height * 0.003)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        replyButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.042)
            make.width.equalTo(UIScreen.main.bounds.width * 0.109)
            make.height.equalTo(UIScreen.main.bounds.width * 0.117)
        }
    }
    private func setSendingStrangerUI() {
        titleImageView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width * 0.133)
            make.height.equalTo(UIScreen.main.bounds.width * 0.112)
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.028)
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width * 0.053)
        }
        transportationImageView.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.bottom).offset(UIScreen.main.bounds.height * 0.015)
            make.centerX.equalTo(titleImageView.snp.centerX)
            make.width.height.equalTo(UIScreen.main.bounds.width * 0.047)
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 0.021).priority(.low)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleImageView.snp.centerY)
            make.leading.equalTo(titleImageView.snp.trailing).offset(UIScreen.main.bounds.width * 0.038)
        }
        transportationState.snp.makeConstraints { make in
            make.centerY.equalTo(transportationImageView.snp.centerY)
            make.leading.equalTo(titleLabel.snp.leading).inset(UIScreen.main.bounds.height * 0.003)
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.096)
            make.height.equalTo(UIScreen.main.bounds.width * 0.042)
        }
    }
    private func setSendingFriendUI() {
        titleImageView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width * 0.133)
            make.height.equalTo(UIScreen.main.bounds.width * 0.112)
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.028)
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width * 0.053)
        }
        transportationImageView.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.bottom).offset(UIScreen.main.bounds.height * 0.015)
            make.centerX.equalTo(titleImageView.snp.centerX)
            make.width.height.equalTo(UIScreen.main.bounds.width * 0.047)
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 0.021).priority(.low)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.top).inset(UIScreen.main.bounds.height * 0.003)
            make.leading.equalTo(titleImageView.snp.trailing).offset(UIScreen.main.bounds.width * 0.048)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(titleImageView.snp.bottom).inset(UIScreen.main.bounds.height * 0.0015)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        transportationState.snp.makeConstraints { make in
            make.centerY.equalTo(transportationImageView.snp.centerY)
            make.leading.equalTo(titleLabel.snp.leading).inset(UIScreen.main.bounds.height * 0.003)
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.096)
            make.height.equalTo(UIScreen.main.bounds.width * 0.042)
        }
    }
    private func setWaitingUI() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.024)
            make.leading.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.061)
        }
        transportationImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIScreen.main.bounds.height * 0.023)
            make.leading.equalTo(titleLabel.snp.leading).inset(UIScreen.main.bounds.width * 0.016)
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 0.025)
            make.width.height.equalTo(UIScreen.main.bounds.width * 0.047)
        }
        transportationState.snp.makeConstraints { make in
            make.centerY.equalTo(transportationImageView.snp.centerY)
            make.leading.equalTo(transportationImageView.snp.trailing).offset(UIScreen.main.bounds.width * 0.08)
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.096)
            make.height.equalTo(UIScreen.main.bounds.width * 0.042)
        }
    }
}
