import UIKit
import SnapKit

enum MessageType: CaseIterable {
    case normal
    case password
}

enum TransportationType: String, CaseIterable {
    case airplane = "airplane"
    case car = "car"
    case bike = "bike"
    case horse = "horse"
    case running = "running"
    case walk = "walk"
}

class HomeTableViewCell: BaseTC {

    static let identifier = "HomeTableViewCell"
    
    //MARK: - Properties
    private let folderImageView = UIImageView()
    
    private let phoneNumberLabel: UILabel = {
        $0.text = "010-2326-3046"
        $0.font = UIFont(name: "Ramche", size: 17)
        return $0
    }(UILabel())
    
    private let transportationImageView = UIImageView()
    
    private let transportationState = UIImageView()
    
    var model: HomeModel? {
        didSet {
            configureVC()
        }
    }
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //임시
        transportationImageView.image = UIImage(named: "airplaneIcon")
        transportationState.image = UIImage(named: "state01")
    }

    override func addView() {
        addSubview(folderImageView)
        addSubview(phoneNumberLabel)
        addSubview(transportationImageView)
        addSubview(transportationState)
    }
    
    override func setLayout() {
        folderImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
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
            make.width.height.equalTo(15)
        }
        transportationState.snp.makeConstraints { make in
            make.centerY.equalTo(transportationImageView.snp.centerY)
            make.leading.equalTo(transportationImageView.snp.trailing).inset(-10)
            make.height.equalTo(15)
        }
    }
    
    override func configureVC() {
        guard let model = model else { return }
        switch model.type {
        case .normal:
            return folderImageView.image = UIImage(named: "redFolder")
        case .password:
            return folderImageView.image = UIImage(named: "yellowFolder")
        }
        
        TransportationType.allCases.forEach { value in
            if model.transportation == value.rawValue {
                transportationImageView.image = UIImage(named: value.rawValue)
            }
        }
        
        
    }
    
}
