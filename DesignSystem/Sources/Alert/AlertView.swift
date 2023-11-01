import UIKit
import SnapKit
import Then

enum AlertType {
    case confirm
    case yesNo
}

protocol AlertDelegate {
    func exit()
    func yes()
}

public final class AlertView: UIViewController {
    var alertType: AlertType = .confirm
    private let pinkCircle = Circle(.bg, 0.5)
    private let blueCircle = Circle(.third, 0.5)
    private let yellowCircle = Circle(.main, 0.5)
    private let headerView = UIView().then {
        $0.backgroundColor = .color(.dittoLettoColor(.gray1))
    }
    private let alertBackView = UIView().then {
        $0.backgroundColor = .color(.dittoLettoColor(.white))
    }
    let titleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .ramche(.body)
        $0.textColor = .color(.dittoLettoColor(.dark))
    }
    let messageLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .ramche(.headline)
        $0.textColor = .color(.dittoLettoColor(.dark))
    }
    private let horizontalLine = UIView().then {
        $0.backgroundColor = .color(.dittoLettoColor(.gray2))
    }
    private let yesButton = UIButton(type: .system).then {
        $0.setTitleColor(.color(.dittoLettoColor(.dark)), for: .normal)
        $0.titleLabel?.font = .ramche(.subheadline)
    }
    private let noButton = UIButton(type: .system).then {
        $0.setTitleColor(.color(.dittoLettoColor(.dark)), for: .normal)
        $0.titleLabel?.font = .ramche(.subheadline)
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.7)
        addView()
        setLayout()
    }
    func addView() {
        [
            pinkCircle,
            blueCircle,
            yellowCircle
        ].forEach { headerView.addSubview($0) }
        [
            headerView,
            titleLabel,
            messageLabel,
            horizontalLine
        ].forEach { alertBackView.addSubview($0) }
        view.addSubview(alertBackView)
        switch alertType {
        case .confirm:
            alertBackView.addSubview(<#T##view: UIView##UIView#>)
        case .yesNo:
        }
    }
    func setLayout() {
        headerView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.72)
            $0.height.equalToSuperview().multipliedBy(0.022)
            $0.center.equalToSuperview()
        }
        pinkCircle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(8)
            $0.width.height.equalTo(6)
        }
        blueCircle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(pinkCircle.snp.right).offset(5)
            $0.width.height.equalTo(6)
        }
        yellowCircle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(blueCircle.snp.right).offset(5)
            $0.width.height.equalTo(6)
        }
    }
}
