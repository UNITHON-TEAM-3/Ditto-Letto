import UIKit
import SnapKit

class LetterStorageTableViewCell: BaseTC {

    static let identifier = "LetterStorageTableViewCell"
    // MARK: - Properties
    private var titleLabel: UILabel = {
        $0.text = "너랑 지금 가까이 있나봐"
        $0.font = .ramche(.body)
        return $0
    }(UILabel())
    private var transportationImageView = UIImageView()
    private var dateLabel: UILabel = {
        $0.text = "2023-10-24"
        $0.font = .ramche(.caption1)
        return $0
    }(UILabel())
    private let deleteButton: UIButton = {
        $0.setImage(.Image.trashCan, for: .normal)
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
            make.top.equalToSuperview().inset(26)
            make.leading.equalToSuperview().inset(23)
            make.trailing.equalToSuperview().inset(14)
        }
        transportationImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-11)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.height.equalTo(16)
            make.bottom.equalToSuperview().inset(14)
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
        self.setImageForTransportation(model.transportation, transportationImageView)
        dateLabel.text = model.date
    }
}
