import UIKit
import SnapKit

class HomeTableViewCell: BaseTC {
    static let identifier = "HomeTableViewCell"
    // MARK: - Properties
    private let folderImageView = UIImageView()
    private let phoneNumberLabel: UILabel = {
        $0.text = "010-2326-3046"
        $0.font = .ramche(.body)
        return $0
    }(UILabel())
    private let transportationImageView = UIImageView()
    private let transportationState = UIImageView()
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
        addSubview(folderImageView)
        addSubview(phoneNumberLabel)
        addSubview(transportationImageView)
        addSubview(transportationState)
    }
    override func setLayout() {
        folderImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(24)
            make.width.equalTo(57)
            make.height.equalTo(51)
        }
        phoneNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(folderImageView.snp.centerY)
            make.leading.equalTo(folderImageView.snp.trailing).inset(-40)
        }
        transportationImageView.snp.makeConstraints { make in
            make.top.equalTo(folderImageView.snp.bottom).inset(-11)
            make.leading.equalToSuperview().inset(30)
            make.width.height.equalTo(18)
        }
        transportationState.snp.makeConstraints { make in
            make.centerY.equalTo(transportationImageView.snp.centerY)
            make.leading.equalTo(transportationImageView.snp.trailing).inset(-10)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(15)
        }
    }
    override func configureVC() {
        guard let model = model else { return }

        phoneNumberLabel.text = model.phoneNumber

        if model.type == MessageType.normal.rawValue {
            return folderImageView.image = .Image.redFolder
        }
        if model.type == MessageType.password.rawValue {
            return folderImageView.image = .Image.yellowFolder
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
                transportationImageView.image = .Image.airplaneIcon
            } else if model.mediumType == TransportationType.car.rawValue {
                transportationImageView.image = .Image.carIcon
            } else if model.mediumType == TransportationType.bicycle.rawValue {
                transportationImageView.image = .Image.bikeIcon
            } else if model.mediumType == TransportationType.horse.rawValue {
                transportationImageView.image = .Image.horseIcon
            } else if model.mediumType == TransportationType.running.rawValue {
                transportationImageView.image = .Image.runningIcon
            } else if model.mediumType == TransportationType.walk.rawValue {
                transportationState.image = .Image.walkIcon
            }
        }
    }
}
