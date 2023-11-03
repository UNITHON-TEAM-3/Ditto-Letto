import UIKit

public enum AlertType {
    case confirm
    case yesNo
}

public protocol AlertDelegate {
    func exit()
    func yes()
}

public final class AlertView: UIViewController {
    var delegate: AlertDelegate?
    public var alertType: AlertType = .confirm
    private let pinkCircle = Circle(.bg, 0.5, 3)
    private let blueCircle = Circle(.third, 0.5, 3)
    private let yellowCircle = Circle(.main, 0.5, 3)
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
        $0.textAlignment = .center
        return $0
    }(UILabel())
    public let messageLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = .ramche(.footnote)
        $0.textColor = .color(.dittoLettoColor(.dark))
        $0.textAlignment = .center
        return $0
    }(UILabel())
    private let horizontalLine: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.gray2))
        return $0
    }(UIView())
    private let confirmButton: UIButton = {
        $0.setTitleColor(.color(.dittoLettoColor(.dark)), for: .normal)
        $0.titleLabel?.font = .ramche(.subheadline)
        $0.backgroundColor = .clear
        return $0
    }(UIButton(type: .system))
    private let cancelButton: UIButton = {
        $0.setTitleColor(.color(.dittoLettoColor(.dark)), for: .normal)
        $0.titleLabel?.font = .ramche(.subheadline)
        $0.backgroundColor = .clear
        return $0
    }(UIButton(type: .system))
    private let verticalLine: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.gray2))
        return $0
    }(UIView())
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red.withAlphaComponent(0.3)
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

        NSLayoutConstraint.activate([
            alertBackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            alertBackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            alertBackView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.72),

            headerView.topAnchor.constraint(equalTo: alertBackView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.022),
            headerView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.72),

            pinkCircle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            pinkCircle.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 8),
            pinkCircle.widthAnchor.constraint(equalToConstant: 6),
            pinkCircle.heightAnchor.constraint(equalToConstant: 6),

            blueCircle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            blueCircle.leftAnchor.constraint(equalTo: pinkCircle.rightAnchor, constant: 5),
            blueCircle.widthAnchor.constraint(equalToConstant: 6),
            blueCircle.heightAnchor.constraint(equalToConstant: 6),

            yellowCircle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            yellowCircle.leftAnchor.constraint(equalTo: blueCircle.rightAnchor, constant: 5),
            yellowCircle.widthAnchor.constraint(equalToConstant: 6),
            yellowCircle.heightAnchor.constraint(equalToConstant: 6),

            titleLabel.leftAnchor.constraint(equalTo: alertBackView.leftAnchor, constant: self.view.frame.width * 0.09),
            titleLabel.rightAnchor.constraint(equalTo: alertBackView.rightAnchor, constant: (-1) * self.view.frame.width * 0.09),
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20)
        ])
    }
    func setUpConfirm() {
        confirmButton.titleLabel?.text = "확인"

        [ horizontalLine, confirmButton ].forEach { alertBackView.addSubview($0) }

        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            horizontalLine.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.72),
            horizontalLine.heightAnchor.constraint(equalToConstant: 1),
            horizontalLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),

            confirmButton.centerXAnchor.constraint(equalTo: alertBackView.centerXAnchor),
            confirmButton.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 10),
            confirmButton.bottomAnchor.constraint(equalTo: alertBackView.bottomAnchor, constant: 10)
        ])
    }
    func setUpYesNo() {
        confirmButton.titleLabel?.text = "네"
        cancelButton.titleLabel?.text = "아니오"
        messageLabel.setTracking()

        [
            messageLabel,
            horizontalLine,
            confirmButton,
            verticalLine,
            cancelButton
        ].forEach { alertBackView.addSubview($0) }

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        verticalLine.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leftAnchor.constraint(equalTo: alertBackView.leftAnchor, constant: self.view.frame.width * 0.122),
            messageLabel.rightAnchor.constraint(equalTo: alertBackView.rightAnchor, constant: (-1) * self.view.frame.width * 0.122),

            horizontalLine.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.72),
            horizontalLine.heightAnchor.constraint(equalToConstant: 1),
            horizontalLine.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),

            confirmButton.rightAnchor.constraint(equalTo: alertBackView.centerXAnchor, constant: -60),
            confirmButton.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 10),
            confirmButton.bottomAnchor.constraint(equalTo: alertBackView.bottomAnchor, constant: 10),

            verticalLine.centerXAnchor.constraint(equalTo: alertBackView.centerXAnchor),
            verticalLine.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor),
            verticalLine.bottomAnchor.constraint(equalTo: alertBackView.bottomAnchor),

            cancelButton.leftAnchor.constraint(equalTo: alertBackView.centerXAnchor, constant: 60),
            cancelButton.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 10),
            cancelButton.bottomAnchor.constraint(equalTo: alertBackView.bottomAnchor, constant: 10)
        ])
    }
}

public extension UILabel {
    func setTracking() {
        let attrString = NSMutableAttributedString(string: self.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .center
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}
