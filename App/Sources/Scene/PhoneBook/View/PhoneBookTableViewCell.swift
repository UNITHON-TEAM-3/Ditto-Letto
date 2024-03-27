import UIKit
import DesignSystem
import SnapKit

protocol PhoneBookTableViewCellDelegate: AnyObject {
    func settingButtonTap()
}
class PhoneBookTableViewCell: BaseTC {
    static let identifier = "PhoneBookTableViewCell"
    var model: PhoneBookModel? {
        didSet {
            configureVC()
        }
    }
    weak var delegate: PhoneBookTableViewCellDelegate?
    // MARK: - Properties
    private let emoziImageView: UIImageView = {
        $0.image = .Image.message
        return $0
    }(UIImageView())
    private let nameLabel: UILabel = {
        $0.text = "내 베프 ><"
        $0.font = .ramche(.subheadline)
        $0.textColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UILabel())
    private let numberLabel: UILabel = {
        $0.text = "010-1234-5678"
        $0.font = .ramche(.caption1)
        $0.textColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UILabel())
    private let settingButton: UIButton = {
        $0.setImage(UIImage(asset: DesignSystemAsset.Image.threeDot), for: .normal)
        $0.addTarget(self, action: #selector(settingButtonTap), for: .touchUpInside)
        return $0
    }(UIButton())
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    override func addView() {
        [
            emoziImageView,
            nameLabel,
            numberLabel,
            settingButton
        ].forEach {
            contentView.addSubview($0)
        }
    }
    override func setLayout() {
        emoziImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.031)
            make.width.height.equalTo(UIScreen.main.bounds.width * 0.13)
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width * 0.013)
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 0.023).priority(.low)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(emoziImageView.snp.top).inset(UIScreen.main.bounds.height * 0.007)
            make.leading.equalTo(emoziImageView.snp.trailing).inset(-(UIScreen.main.bounds.width * 0.048))
        }
        numberLabel.snp.makeConstraints { make in
            make.bottom.equalTo(emoziImageView.snp.bottom).inset(UIScreen.main.bounds.height * 0.007)
            make.leading.equalTo(nameLabel.snp.leading)
        }
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(emoziImageView.snp.top).inset(UIScreen.main.bounds.height * 0.008)
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.069)
            make.width.equalTo(UIScreen.main.bounds.width * 0.012)
            make.height.equalTo(UIScreen.main.bounds.height * 0.042)
        }
    }
    override func configureVC() {
        guard let model = model else { return }
        nameLabel.text = model.phoneBookName
        numberLabel.text = model.phoneBookNumber
    }
    @objc private func settingButtonTap() {
        delegate?.settingButtonTap()
    }
}
