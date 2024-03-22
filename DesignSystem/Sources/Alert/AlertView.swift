import UIKit

public enum AlertType {
    case confirm
    case yesNo
}

public protocol AlertDelegate: AnyObject {
    func exit()
    func yes()
}

public final class AlertView: UIViewController {
    weak var delegate: AlertDelegate?
    public var alertType: AlertType = .confirm
    public var alertTitle: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    public var alertContent: String {
        get { messageLabel.text ?? "" }
        set {
            messageLabel.text = newValue
            messageLabel.setTracking()
        }
    }
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
    private let titleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = .ramche(.body)
        $0.textColor = .color(.dittoLettoColor(.dark))
        $0.textAlignment = .center
        $0.backgroundColor = .clear
        return $0
    }(UILabel())
    private let messageLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = .ramche(.footnote)
        $0.textColor = .color(.dittoLettoColor(.dark))
        $0.textAlignment = .center
        $0.backgroundColor = .clear
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

    public init(delegate: AlertDelegate?, alertType: AlertType) {
        super.init(nibName: nil, bundle: nil)
        self.alertType = alertType
        self.delegate = delegate
        view.backgroundColor = .black.withAlphaComponent(0.3)
        self.modalPresentationStyle = .overFullScreen
        addView()
        setLayout()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        case .yesNo:
            setUpYesNo()
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
            titleLabel.rightAnchor.constraint(
                equalTo: alertBackView.rightAnchor,
                constant: -self.view.frame.width * 0.09
            ),
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20)
        ])
    }

    func setUpConfirm() {
        confirmButton.setTitle("확인", for: .normal)

        [ horizontalLine, confirmButton ].forEach { alertBackView.addSubview($0) }

        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            horizontalLine.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.72),
            horizontalLine.heightAnchor.constraint(equalToConstant: 1),
            horizontalLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),

            confirmButton.centerXAnchor.constraint(equalTo: alertBackView.centerXAnchor),
            confirmButton.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 10),
            confirmButton.bottomAnchor.constraint(equalTo: alertBackView.bottomAnchor, constant: -10)
        ])

        confirmButton.addAction(UIAction { [weak self] _ in
            self?.delegate?.yes()
        }, for: .allTouchEvents)
    }

    func setUpYesNo() {
        confirmButton.setTitle("네", for: .normal)
        cancelButton.setTitle("아니오", for: .normal)
        messageLabel.setTracking()

        [
            messageLabel,
            horizontalLine,
            verticalLine,
            confirmButton,
            cancelButton
        ].forEach { alertBackView.addSubview($0) }

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        verticalLine.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leftAnchor.constraint(
                equalTo: alertBackView.leftAnchor,
                constant: 27
            ),
            messageLabel.rightAnchor.constraint(
                equalTo: alertBackView.rightAnchor,
                constant: -27
            ),

            horizontalLine.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.72),
            horizontalLine.heightAnchor.constraint(equalToConstant: 1),
            horizontalLine.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),

            verticalLine.centerXAnchor.constraint(equalTo: alertBackView.centerXAnchor),
            verticalLine.widthAnchor.constraint(equalToConstant: 1),
            verticalLine.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor),
            verticalLine.bottomAnchor.constraint(equalTo: alertBackView.bottomAnchor),

            confirmButton.leftAnchor.constraint(equalTo: alertBackView.leftAnchor),
            confirmButton.rightAnchor.constraint(equalTo: verticalLine.leftAnchor),
            confirmButton.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 10),
            confirmButton.bottomAnchor.constraint(equalTo: alertBackView.bottomAnchor, constant: -10),

            cancelButton.leftAnchor.constraint(equalTo: verticalLine.rightAnchor),
            cancelButton.rightAnchor.constraint(equalTo: alertBackView.rightAnchor),
            cancelButton.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 10),
            cancelButton.bottomAnchor.constraint(equalTo: alertBackView.bottomAnchor, constant: -10)
        ])

        confirmButton.addAction(UIAction { [weak self] _ in
            self?.delegate?.yes()
            print("Yes")
        }, for: .allTouchEvents)

        cancelButton.addAction(UIAction { [weak self] _ in
            self?.delegate?.exit()
            print("Exit")
        }, for: .allTouchEvents)
    }
}

public extension UILabel {
    func setTracking() {
        let attrString = NSMutableAttributedString(string: self.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        paragraphStyle.alignment = .center
        attrString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attrString.length)
        )
        self.attributedText = attrString
    }
}
