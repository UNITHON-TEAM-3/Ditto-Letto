import UIKit

public enum AlertType {
    case confirm
    case yesNo
}

protocol AlertDelegate {
    func exit()
    func yes()
}

public final class AlertView: UIViewController {
    var delegate: AlertDelegate?
    public var alertType: AlertType = .confirm
    private let pinkCircle = Circle(.bg, 0.5)
    private let blueCircle = Circle(.third, 0.5)
    private let yellowCircle = Circle(.main, 0.5)
    private let headerView: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.gray1))
        return $0
    }(UIView())
    private let alertBackView: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.white))
        return $0
    }(UIView())
    public let titleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = .ramche(.body)
        $0.textColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UILabel())
    public let messageLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = .ramche(.headline)
        $0.textColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UILabel())
    private let horizontalLine: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.gray2))
        return $0
    }(UIView())
    private let confirmButton: UIButton = {
        $0.setTitleColor(.color(.dittoLettoColor(.dark)), for: .normal)
        $0.titleLabel?.font = .ramche(.subheadline)
        return $0
    }(UIButton(type: .system))
    private let cancelButton: UIButton = {
        $0.setTitleColor(.color(.dittoLettoColor(.dark)), for: .normal)
        $0.titleLabel?.font = .ramche(.subheadline)
        return $0
    }(UIButton(type: .system))
    private let verticalLine:  UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.gray2))
        return $0
    }(UIView())
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.7)
        addView()
        setLayout()
    }
    func addView() {
        view.addSubview(alertBackView)
        [
            headerView,
            titleLabel,
            horizontalLine
        ].forEach { alertBackView.addSubview($0) }
        [
            pinkCircle,
            blueCircle,
            yellowCircle
        ].forEach { headerView.addSubview($0) }
        switch alertType {
        case .confirm:
            setUpConfirm()
            delegate?.exit()
        case .yesNo:
            setUpYesNo()
            delegate?.yes()
            delegate?.exit()
        }
    }
    func setLayout() {
        pinkCircle.translatesAutoresizingMaskIntoConstraints = false
        blueCircle.translatesAutoresizingMaskIntoConstraints = false
        yellowCircle.translatesAutoresizingMaskIntoConstraints = false
        alertBackView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        verticalLine.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
//        alertBackView.snp.makeConstraints {
//            $0.width.equalToSuperview().multipliedBy(0.72)
//            $0.center.equalToSuperview()
//        }
//        headerView.snp.makeConstraints {
////            $0.width.equalToSuperview().multipliedBy(0.72)
//            $0.height.equalToSuperview().multipliedBy(0.022)
//            $0.top.horizontalEdges.equalToSuperview()
//        }
//        pinkCircle.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.left.equalToSuperview().inset(8)
//            $0.width.height.equalTo(6)
//        }
//        blueCircle.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.left.equalTo(pinkCircle.snp.right).offset(5)
//            $0.width.height.equalTo(6)
//        }
//        yellowCircle.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.left.equalTo(blueCircle.snp.right).offset(5)
//            $0.width.height.equalTo(6)
//        }
//        titleLabel.snp.makeConstraints {
//            $0.top.equalTo(headerView.snp.bottom).offset(20)
//            $0.centerX.equalToSuperview()
//        }
//        horizontalLine.snp.makeConstraints {
//            $0.horizontalEdges.equalToSuperview()
//            $0.height.equalTo(1)
//            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
//        }
//    }
//    func setUpConfirm() {
//        alertBackView.addSubview(confirmButton)
//        confirmButton.titleLabel?.text = "확인"
//        confirmButton.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(horizontalLine.snp.bottom).offset(10)
//            $0.bottom.equalToSuperview().inset(10)
//        }
//    }
//    func setUpYesNo() {
//        confirmButton.titleLabel?.text = "네"
//        cancelButton.titleLabel?.text = "아니오"
//        [ messageLabel, confirmButton, verticalLine, cancelButton ].forEach { alertBackView.addSubview($0) }
//        messageLabel.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
//            $0.centerX.equalToSuperview()
//        }
//        horizontalLine.snp.updateConstraints {
//            $0.horizontalEdges.equalToSuperview()
//            $0.height.equalTo(1)
//            $0.top.equalTo(messageLabel.snp.bottom).offset(20)
//        }
//        confirmButton.snp.makeConstraints {
//            $0.right.equalTo(alertBackView.snp.centerX).offset(-60)
//            $0.top.equalTo(horizontalLine.snp.bottom).offset(10)
//            $0.bottom.equalToSuperview().inset(10)
//        }
//        verticalLine.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(horizontalLine.snp.bottom).offset(0)
//            $0.bottom.equalToSuperview()
//        }
//        cancelButton.snp.makeConstraints {
//            $0.left.equalTo(alertBackView.snp.centerX).offset(60)
//            $0.top.equalTo(horizontalLine.snp.bottom).offset(10)
//            $0.bottom.equalToSuperview().inset(10)
//        }
    }
}
