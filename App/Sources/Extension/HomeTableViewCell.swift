import UIKit
import SnapKit

enum MessageType: String, CaseIterable {
    case normal = "BASIC"
    case password = "CODE"
}

enum TransportationType: String, CaseIterable {
    case airplane = "PLAIN"
    case car = "CAR"
    case bicycle = "BICYCLE"
    case horse = "HORSE"
    case running = "RUN"
    case walk = "WALK"
}

enum ProgressType: Int, CaseIterable {
    case type1 = 1
    case type2 = 2
    case type3 = 3
    case type4 = 4
    case type5 = 5
    case type6 = 6
    case type7 = 7
}

class HomeTableViewCell: BaseTC {

    static let identifier = "HomeTableViewCell"
    // MARK: - Properties
    private let folderImageView = UIImageView()

    private let phoneNumberLabel: UILabel = {
        $0.text = "010-2326-3046"
        $0.font = DittoLettoFontFamily.Ramche.regular.font(size: 17)
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
            return folderImageView.image = DittoLettoAsset.Image.redFolder.image
        }
        if model.type == MessageType.password.rawValue {
            return folderImageView.image = DittoLettoAsset.Image.yellowFolder.image
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
    }
}
