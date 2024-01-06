import UIKit

public enum MyPageViewType: String {
    case table
    case auth
    case withdrawal
    case notice
}

public final class MyPageContentView: UIView {
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
        return $0
    }(UIView())
    let headerTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .ramche(.body)
        return $0
    }(UILabel())
    let snsImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
        return $0
    }(UIImageView())
    let textLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UILabel())
    let noticeTextView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .ramche(.subheadline)
        $0.textColor = .color(.dittoLettoColor(.white))
        $0.textAlignment = .left
        $0.isEditable = false
        $0.isSelectable = false
        $0.isScrollEnabled = false
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
            setNoticeType()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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

        headerView.backgroundColor = .color(.dittoLettoColor(.third))
        contentView.backgroundColor = .color(.dittoLettoColor(.gray1))
        leftBar.backgroundColor = .color(.dittoLettoColor(.dark))
        rightBar.backgroundColor = .color(.dittoLettoColor(.dark))

        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.03),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.061),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.01),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: 12),
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.061),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.01),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftBar.rightAnchor.constraint(equalTo: rightBar.leftAnchor, constant: 8),
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

        headerView.backgroundColor = .color(.dittoLettoColor(.gray1))
        contentView.backgroundColor = .color(.dittoLettoColor(.white))
        leftBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        rightBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        textLabel.font = .ramche(.subheadline)

        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.064),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.061),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.024),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: UIScreen.main.bounds.width * 0.053),
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.061),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.01),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftBar.rightAnchor.constraint(equalTo: rightBar.leftAnchor, constant: UIScreen.main.bounds.width * 0.042),
            contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.135),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            snsImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            snsImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            snsImageView.widthAnchor.constraint(equalToConstant: 20)
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

        headerView.backgroundColor = .color(.dittoLettoColor(.gray1))
        contentView.backgroundColor = .color(.dittoLettoColor(.white))
        leftBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        rightBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        textLabel.text = "탈퇴하기"
        textLabel.font = .ramche(.body)

        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.03),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.037),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.007),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: UIScreen.main.bounds.width * 0.027),
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

    func setNoticeType() {
        lazy var contentStackView = VStackView(spacing: 0) {
            ZStackView {
                headerView
                leftBar
                rightBar
            }
            ZStackView {
                contentView
                noticeTextView
            }
        }
        self.addSubview(contentStackView)

        headerView.backgroundColor = .color(.dittoLettoColor(.third))
        contentView.backgroundColor = .color(.dittoLettoColor(.dark))
        leftBar.backgroundColor = .color(.dittoLettoColor(.dark))
        rightBar.backgroundColor = .color(.dittoLettoColor(.dark))

        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.064),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.061),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.024),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: UIScreen.main.bounds.width * 0.053),
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.061),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.01),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftBar.rightAnchor.constraint(equalTo: rightBar.leftAnchor, constant: UIScreen.main.bounds.width * 0.042),
            contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.542),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            noticeTextView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
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
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
