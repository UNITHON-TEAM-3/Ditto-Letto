import UIKit
import SnapKit

class LetterStorageTableViewCell: BaseTC {

    static let identifier = "LetterStorageTableViewCell"
    // MARK: - Properties
    private var titleLabel: UILabel = {
        $0.text = "너랑 지금 가까이 있나봐"
        $0.font = DittoLettoFontFamily.Ramche.regular.font(size: 19)
        return $0
    }(UILabel())
    private var transportationImageView = UIImageView()
    private var dateLabel: UILabel = {
        $0.text = "2023-10-24"
        $0.font = DittoLettoFontFamily.Ramche.regular.font(size: 14)
        return $0
    }(UILabel())
    private let deleteButton: UIButton = {
        $0.setImage(DittoLettoAsset.Image.trashCan.image, for: .normal)
        return $0
    }(UIButton())
    var model: LetterStorageModel? {
        didSet {
            configureVC()
        }
    }

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    // MARK: - Set UI
    override func addView() {
        [titleLabel, transportationImageView, dateLabel, deleteButton].forEach {
            addSubview($0)
        }
    }
    override func setLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        transportationImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-16)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.height.equalTo(16)
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(transportationImageView.snp.trailing).inset(-10)
            make.centerY.equalTo(transportationImageView.snp.centerY)
        }
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(18)
            make.width.height.equalTo(16)
        }
    }
    override func configureVC() {
        guard let model = model else { return }
        titleLabel.text = model.content
        if model.transportation == TransportationType.airplane.rawValue {
            transportationImageView.image = DittoLettoAsset.Image.airplaneIcon.image
        } else if model.transportation == TransportationType.car.rawValue {
            transportationImageView.image = DittoLettoAsset.Image.carIcon.image
        } else if model.transportation == TransportationType.bicycle.rawValue {
            transportationImageView.image = DittoLettoAsset.Image.bikeIcon.image
        } else if model.transportation == TransportationType.horse.rawValue {
            transportationImageView.image = DittoLettoAsset.Image.horseIcon.image
        } else if model.transportation == TransportationType.running.rawValue {
            transportationImageView.image = DittoLettoAsset.Image.runningIcon.image
        } else if model.transportation == TransportationType.walk.rawValue {
            transportationImageView.image = DittoLettoAsset.Image.walkIcon.image
        }
        dateLabel.text = model.date
    }
}
