import UIKit
import SnapKit

class HomeTableHeaderView: UIView {
    var model: BoxLetterData? {
        didSet {
            configureVC()
        }
    }

    private let headerTitleLabel: UILabel = {
        $0.text = "너랑 지금 정말 가까이 있나봐"
        $0.font = UIFont(name: "Ramche", size: 16)
        return $0
    }(UILabel())

    private let transportationImageView = UIImageView()

    private let transportationState = UIImageView()

    private let lineView: UIView = {
        $0.backgroundColor = UIColor(named: "gray2")
        return $0
    }(UIView())

    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()

        // 임시
        transportationImageView.image = UIImage(named: "horseIcon")
        transportationState.image = UIImage(named: "state03")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set UI
    private func addView() {
        addSubview(headerTitleLabel)
        addSubview(transportationImageView)
        addSubview(transportationState)
        addSubview(lineView)
    }

    private func setLayout() {
        headerTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(22)
        }
        transportationImageView.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).inset(-15)
            make.leading.equalToSuperview().inset(22)
            make.width.height.equalTo(18)
        }
        transportationState.snp.makeConstraints { make in
            make.centerY.equalTo(transportationImageView.snp.centerY)
            make.leading.equalTo(transportationImageView.snp.trailing).inset(-10)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(15)
        }
        lineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }

    private func configureVC() {
        guard let model = model else { return }

        headerTitleLabel.text = model.previewText
        // 도착까지 시간이 남았을 시
        ProgressType.allCases.forEach { value in
            if model.progressLevel == value.rawValue {
                transportationState.image = UIImage(named: "state0\(value.rawValue)")
            }
        }
    
        if model.mediumType == TransportationType.airplane.rawValue {
            transportationImageView.image = UIImage(named: "airplaneIcon")
        } else if model.mediumType == TransportationType.car.rawValue {
            transportationImageView.image = UIImage(named: "carIcon")
        } else if model.mediumType == TransportationType.bicycle.rawValue {
            transportationImageView.image = UIImage(named: "bikeIcon")
        } else if model.mediumType == TransportationType.horse.rawValue {
            transportationImageView.image = UIImage(named: "horseIcon")
        } else if model.mediumType == TransportationType.running.rawValue {
            transportationImageView.image = UIImage(named: "runningIcon")
        } else if model.mediumType == TransportationType.walk.rawValue {
            transportationState.image = UIImage(named: "walkIcon")
        }
    }
}
