import UIKit

public enum MyPageViewType: String {
    case table
    case auth
    case withdrawal
    case notice
}

public class MyPageContentView: UIView {
    public var noticeTypeHeight = CGFloat()
    private let headerView: UIView = {
        $0.layer.borderColor = UIColor.color(.dittoLettoColor(.dark)).cgColor
        $0.layer.borderWidth = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private let leftBar: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private let rightBar: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.addBorder([.top, .left], .color(.dittoLettoColor(.dark)), UIScreen.main.bounds.width * 0.003)
        $0.layer.addBorder([.right, .bottom], .color(.dittoLettoColor(.dark)), UIScreen.main.bounds.width * 0.005)
        return $0
    }(UIView())
    public let headerTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .ramche(.body)
        $0.backgroundColor = .clear
        return $0
    }(UILabel())
    public let snsImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
        return $0
    }(UIImageView())
    public let textLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .color(.dittoLettoColor(.dark))
        $0.backgroundColor = .clear
        return $0
    }(UILabel())
    public let noticeTextView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .ramche(.subheadline)
        $0.textColor = .color(.dittoLettoColor(.white))
        $0.textAlignment = .left
        $0.isEditable = false
        $0.isSelectable = false
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        return $0
    }(UITextView())

    public init(_ type: MyPageViewType) {
        super.init(frame: .zero)

        switch type {
        case .table:
            setTableType()
        case .auth:
            setAuthType()
        case .withdrawal:
            setWithdrawalType()
        case .notice:
            setNoticeType(self.noticeTypeHeight)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// swiftlint:disable function_body_length
extension MyPageContentView {
    func setTableType() {
        lazy var contentStackView = VStackView(spacing: 0) {
            ZStackView {
                headerView
                leftBar
                rightBar
            }
            contentView
        }
        self.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        headerView.backgroundColor = .color(.dittoLettoColor(.third))
        contentView.backgroundColor = .color(.dittoLettoColor(.gray1))
        leftBar.backgroundColor = .color(.dittoLettoColor(.dark))
        rightBar.backgroundColor = .color(.dittoLettoColor(.dark))

        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.893),
            contentStackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.572),
            headerView.leftAnchor.constraint(equalTo: contentStackView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: contentStackView.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.03),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.061),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.01),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -12),
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.061),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.01),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftBar.rightAnchor.constraint(equalTo: rightBar.leftAnchor, constant: -8),
            contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.542),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: headerView.rightAnchor)
        ])
    }

    func setAuthType() {
        lazy var contentStackView = VStackView(spacing: 0) {
            ZStackView {
                headerView
                headerTitleLabel
                leftBar
                rightBar
            }
            ZStackView {
                contentView
                snsImageView
                textLabel
            }
        }
        self.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        headerView.backgroundColor = .color(.dittoLettoColor(.gray1))
        contentView.backgroundColor = .color(.dittoLettoColor(.white))
        leftBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        rightBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        headerTitleLabel.text = "SNS 연동"
        headerTitleLabel.textColor = .color(.dittoLettoColor(.dark))
        textLabel.font = .ramche(.subheadline)

        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.893),
            contentStackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.198),
            headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.064),
            headerTitleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerTitleLabel.leftAnchor.constraint(equalTo: contentStackView.leftAnchor, constant: 0.056),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.049),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.019),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.rightAnchor.constraint(
                equalTo: contentStackView.rightAnchor,
                constant: -UIScreen.main.bounds.width * 0.055
            ),
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.049),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.01),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftBar.rightAnchor.constraint(equalTo: rightBar.leftAnchor, constant: -UIScreen.main.bounds.width * 0.042),
            contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.135),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            snsImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            snsImageView.leftAnchor.constraint(equalTo: contentStackView.leftAnchor, constant: 20),
            snsImageView.widthAnchor.constraint(equalToConstant: 20),
            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textLabel.leftAnchor.constraint(equalTo: snsImageView.rightAnchor, constant: 20),
            textLabel.rightAnchor.constraint(equalTo: contentStackView.rightAnchor, constant: -50)
        ])
    }

    func setWithdrawalType() {
        lazy var contentStackView = VStackView(spacing: 0) {
            ZStackView {
                headerView
                leftBar
                rightBar
            }
            ZStackView {
                contentView
                textLabel
            }
        }
        self.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        headerView.backgroundColor = .color(.dittoLettoColor(.gray1))
        contentView.backgroundColor = .color(.dittoLettoColor(.white))
        leftBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        rightBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        textLabel.text = "탈퇴하기"
        textLabel.font = .ramche(.body)

        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.48),
            contentStackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.127),
            headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.03),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.037),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.007),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.rightAnchor.constraint(
                equalTo: headerView.rightAnchor,
                constant: UIScreen.main.bounds.width * 0.027
            ),
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.037),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.012),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftBar.rightAnchor.constraint(equalTo: rightBar.leftAnchor, constant: UIScreen.main.bounds.width * 0.016),
            contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.542),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func setNoticeType(_ height: CGFloat) {
        lazy var contentStackView = VStackView(spacing: 0) {
            ZStackView {
                headerView
                headerTitleLabel
                leftBar
                rightBar
            }
            ZStackView {
                contentView
                noticeTextView
            }
        }
        self.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        headerView.backgroundColor = .color(.dittoLettoColor(.third))
        contentView.backgroundColor = .color(.dittoLettoColor(.dark))
        leftBar.backgroundColor = .color(.dittoLettoColor(.dark))
        rightBar.backgroundColor = .color(.dittoLettoColor(.dark))
        headerTitleLabel.textColor = .color(.dittoLettoColor(.white))

        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.893),
            headerView.leftAnchor.constraint(equalTo: contentStackView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: contentStackView.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.064),
            headerTitleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerTitleLabel.leftAnchor.constraint(
                equalTo: contentStackView.leftAnchor,
                constant: UIScreen.main.bounds.width * 0.053
            ),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.049),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.019),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.rightAnchor.constraint(
                equalTo: contentStackView.rightAnchor,
                constant: -UIScreen.main.bounds.width * 0.055
            ),
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.049),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.01),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftBar.rightAnchor.constraint(
                equalTo: rightBar.leftAnchor,
                constant: -UIScreen.main.bounds.width * 0.042
            ),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            noticeTextView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: UIScreen.main.bounds.height * 0.03
            ),
            noticeTextView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -UIScreen.main.bounds.height * 0.03
            ),
            noticeTextView.leftAnchor.constraint(
                equalTo: contentStackView.leftAnchor,
                constant: UIScreen.main.bounds.width * 0.053
            ),
            noticeTextView.rightAnchor.constraint(
                equalTo: contentStackView.rightAnchor,
                constant: -UIScreen.main.bounds.width * 0.053
            )
        ])
    }
}

extension CALayer {
    func addBorder(
        _ edges: [UIRectEdge],
        _ color: UIColor,
        _ width: CGFloat
    ) {
        for edge in edges {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
            default:
                break
            }
            borderColor = UIColor.color(.dittoLettoColor(.dark)).cgColor
            borderWidth = width
            self.addSublayer(border)
        }
    }
}
// swiftlint:enable function_body_length
