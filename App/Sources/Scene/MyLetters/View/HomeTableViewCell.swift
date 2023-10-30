import UIKit
import SnapKit

class HomeTableViewCell: BaseTC {
    static let identifier = "HomeTableViewCell"
    // MARK: - Properties
    private let titleImageView = UIImageView()
    private let titleLabel: UILabel = {
        $0.text = "010-2326-3046"
        $0.font = DittoLettoFontFamily.Ramche.regular.font(size: 17)
        return $0
    }(UILabel())
    private let subTitleLabel: UILabel = {
        $0.text = "010-2326-3046"
        $0.font = DittoLettoFontFamily.Ramche.regular.font(size: 13)
        return $0
    }(UILabel())
    private let transportationImageView = UIImageView()
    private let transportationState = UIImageView()
    private let replyButton: UIButton = {
        $0.setImage(DittoLettoAsset.Image.replyButton.image, for: .normal)
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
        [titleImageView, titleLabel, subTitleLabel, transportationImageView, transportationState, replyButton].forEach {
            addSubview($0)
        }
        setLayout(type: .waiting)
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
        case.sendingfriend:
            setSendingFriendUI()
        case .waiting:
            setWaitingUI()
        }
    }
    override func configureVC() {
        guard let model = model else { return }
        titleLabel.text = model.phoneNumber
        if model.type == MessageType.normal.rawValue {
            titleImageView.image = DittoLettoAsset.Image.redFolder.image
        }
        if model.type == MessageType.password.rawValue {
            titleImageView.image = DittoLettoAsset.Image.yellowFolder.image
        }

        // 도착 완료 시
        if model.arrived {
            transportationImageView.image = nil
            transportationState.image = nil
        } else {
            // 도착까지 시간이 남았을 시
            ProgressType.allCases.forEach { value in
                if model.progressLevel == value.rawValue {
                    transportationState.image = UIImage(named: "state0\(value.rawValue)")
                }
            }
            if model.mediumType == TransportationType.airplane.rawValue {
                transportationImageView.image = DittoLettoAsset.Image.airplaneIcon.image
            } else if model.mediumType == TransportationType.car.rawValue {
                transportationImageView.image = DittoLettoAsset.Image.carIcon.image
            } else if model.mediumType == TransportationType.bicycle.rawValue {
                transportationImageView.image = DittoLettoAsset.Image.bikeIcon.image
            } else if model.mediumType == TransportationType.horse.rawValue {
                transportationImageView.image = DittoLettoAsset.Image.horseIcon.image
            } else if model.mediumType == TransportationType.running.rawValue {
                transportationImageView.image = DittoLettoAsset.Image.runningIcon.image
            } else if model.mediumType == TransportationType.walk.rawValue {
                transportationState.image = DittoLettoAsset.Image.walkIcon.image
            }
        }
        // 임시
        transportationState.image = UIImage(named: "state03")
        transportationImageView.image = DittoLettoAsset.Image.airplaneIcon.image
    }
}

extension HomeTableViewCell {
    private func setStrangerUI() {
        titleImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(17.13)
            make.bottom.equalToSuperview().inset(19.83)
            make.leading.equalToSuperview().inset(24)
            make.width.equalTo(50)
            make.height.equalTo(44.74)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(30)
            make.centerY.equalTo(titleImageView.snp.centerY)
            make.leading.equalTo(titleImageView.snp.trailing).inset(-40)
        }
        replyButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(41)
            make.height.equalTo(44)
        }
    }
    private func setFriendUI() {
        titleImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.top.equalToSuperview().inset(14.19)
            make.bottom.equalToSuperview().inset(17.51)
            make.leading.equalToSuperview().inset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.top).inset(2)
            make.leading.equalTo(titleImageView.snp.trailing).inset(-18)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(titleImageView.snp.bottom).inset(2)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        replyButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(41)
            make.height.equalTo(44)
        }
    }
    private func setSendingStrangerUI() {
        titleImageView.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(44.74)
            make.top.equalToSuperview().inset(19.19)
            make.bottom.equalToSuperview().inset(35.81)
            make.leading.equalToSuperview().inset(20)
        }
        transportationImageView.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.bottom).inset(-8)
            make.centerX.equalTo(titleImageView.snp.centerX)
            make.height.width.equalTo(16)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleImageView.snp.centerY)
            make.leading.equalTo(titleImageView.snp.trailing).inset(-14.5)
        }
        transportationState.snp.makeConstraints { make in
            make.centerY.equalTo(transportationImageView.snp.centerY)
            make.leading.equalTo(titleLabel.snp.leading).inset(2)
            make.trailing.equalToSuperview().inset(36)
            make.height.equalTo(16)
        }
    }
    private func setSendingFriendUI() {
        titleImageView.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(44.74)
            make.top.equalToSuperview().inset(19.19)
            make.bottom.equalToSuperview().inset(35.81)
            make.leading.equalToSuperview().inset(20)
        }
        transportationImageView.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.bottom).inset(-8)
            make.centerX.equalTo(titleImageView.snp.centerX)
            make.height.width.equalTo(16)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.top).inset(2)
            make.leading.equalTo(titleImageView.snp.trailing).inset(-18)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(titleImageView.snp.bottom).inset(2)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        transportationState.snp.makeConstraints { make in
            make.centerY.equalTo(transportationImageView.snp.centerY)
            make.leading.equalTo(titleLabel.snp.leading).inset(2)
            make.trailing.equalToSuperview().inset(36)
            make.height.equalTo(16)
        }
    }
    private func setWaitingUI() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(23)
        }
        transportationImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-15.7)
            make.leading.equalTo(titleLabel.snp.leading).inset(6)
            make.bottom.equalToSuperview().inset(17)
            make.width.height.equalTo(16)
        }
        transportationState.snp.makeConstraints { make in
            make.centerY.equalTo(transportationImageView.snp.centerY)
            make.leading.equalTo(transportationImageView.snp.trailing).inset(-30)
            make.trailing.equalToSuperview().inset(36)
            make.height.equalTo(16)
        }
    }
}
