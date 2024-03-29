import UIKit

public enum MyPageViewType: String {
    case header
    case auth
    case withdrawal
    case notice
}

public class MyPageContentView: UIView {
    public var headerText: String {
        get { headerTitleLabel.text ?? "" }
        set { headerTitleLabel.text = newValue }
    }
    public var labelText: String {
        get { snsTextLabel.text ?? "" }
        set { snsTextLabel.text = newValue }
    }
    public var authImage: UIImage {
        get { snsImageView.image ?? UIImage() }
        set { snsImageView.image = newValue }
    }
    public var textViewText: String {
        get { noticeTextView.text ?? "" }
        set { noticeTextView.text = newValue }
    }
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
    public lazy var contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor.color(.dittoLettoColor(.dark)).cgColor
        $0.layer.borderWidth = 1
        return $0
    }(UIView())
    private let headerTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .ramche(.body)
        $0.backgroundColor = .clear
        return $0
    }(UILabel())
    private let snsImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
        return $0
    }(UIImageView())
    private let snsTextLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .color(.dittoLettoColor(.dark))
        $0.backgroundColor = .clear
        return $0
    }(UILabel())
    private let noticeTextView: UITextView = {
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
    private let bottomBorderView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        $0.backgroundColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UIView())
    private let rightBorderView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        $0.backgroundColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UIView())

    public init(_ type: MyPageViewType) {
        super.init(frame: .zero)
        switch type {
        case .header:
            setBasicType()
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

// swiftlint:disable function_body_length
// swiftlint:disable file_length
extension MyPageContentView {
    func setBasicType() {
        lazy var contentStackView = VStackView(spacing: 0) {
            ZStackView {
                headerView
                leftBar
                rightBar
            }
        }
        self.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.isUserInteractionEnabled = true

        headerView.backgroundColor = .color(.dittoLettoColor(.third))
        contentView.backgroundColor = .color(.dittoLettoColor(.gray1))
        leftBar.backgroundColor = .color(.dittoLettoColor(.dark))
        rightBar.backgroundColor = .color(.dittoLettoColor(.dark))

        NSLayoutConstraint.activate([
            contentStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            contentStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            headerView.leftAnchor.constraint(equalTo: contentStackView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: contentStackView.rightAnchor),
            headerView.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            headerView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.061),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.01),
            rightBar.topAnchor.constraint(
                equalTo: headerView.topAnchor,
                constant: UIScreen.main.bounds.height * 0.01
            ),
            rightBar.bottomAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: -UIScreen.main.bounds.height * 0.01
            ),
            rightBar.rightAnchor.constraint(
                equalTo: headerView.rightAnchor,
                constant: -UIScreen.main.bounds.width * 0.032
            ),
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.061),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.01),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftBar.rightAnchor.constraint(
                equalTo: rightBar.leftAnchor,
                constant: -UIScreen.main.bounds.width * 0.021
            )
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
                snsTextLabel
            }
            bottomBorderView
        }
        [
            contentStackView,
            rightBorderView
        ].forEach { self.addSubview($0) }
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.isUserInteractionEnabled = true

        headerView.backgroundColor = .color(.dittoLettoColor(.gray1))
        contentView.backgroundColor = .color(.dittoLettoColor(.white))
        leftBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        rightBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        headerTitleLabel.text = "SNS 연동"
        headerTitleLabel.textColor = .color(.dittoLettoColor(.dark))
        snsTextLabel.font = .ramche(.subheadline)

        NSLayoutConstraint.activate([
            contentStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            contentStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            headerView.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            headerView.leftAnchor.constraint(equalTo: contentStackView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: contentStackView.rightAnchor),
            headerTitleLabel.topAnchor.constraint(
                equalTo: headerView.topAnchor,
                constant: UIScreen.main.bounds.height * 0.019
            ),
            headerTitleLabel.bottomAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: -UIScreen.main.bounds.height * 0.019
            ),
            headerTitleLabel.leftAnchor.constraint(
                equalTo: contentStackView.leftAnchor,
                constant: UIScreen.main.bounds.width * 0.053
            ),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.049),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.017),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.rightAnchor.constraint(
                equalTo: contentStackView.rightAnchor,
                constant: -UIScreen.main.bounds.width * 0.053
            ),
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.049),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.009),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftBar.rightAnchor.constraint(
                equalTo: rightBar.leftAnchor,
                constant: -UIScreen.main.bounds.width * 0.04
            ),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            snsImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            snsImageView.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: UIScreen.main.bounds.width * 0.06
            ),
            snsImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.053),
            snsImageView.heightAnchor.constraint(equalToConstant: 24),
            snsTextLabel.leftAnchor.constraint(
                equalTo: snsImageView.rightAnchor,
                constant: UIScreen.main.bounds.width * 0.055
            ),
            snsTextLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: UIScreen.main.bounds.height * 0.044
            ),
            snsTextLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -UIScreen.main.bounds.height * 0.044
            ),
            bottomBorderView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomBorderView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: 1),
            bottomBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            rightBorderView.widthAnchor.constraint(equalToConstant: 1),
            rightBorderView.leftAnchor.constraint(equalTo: contentStackView.rightAnchor),
            rightBorderView.topAnchor.constraint(equalTo: self.topAnchor),
            rightBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func setWithdrawalType() {
        lazy var contentStackView = VStackView(spacing: 0) {
            ZStackView {
                headerView
                rightBar
                leftBar
            }
            contentView
            bottomBorderView
        }
        [
            contentStackView,
            rightBorderView
        ].forEach { self.addSubview($0) }
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.isUserInteractionEnabled = true

        headerView.backgroundColor = .color(.dittoLettoColor(.gray1))
        contentView.backgroundColor = .color(.dittoLettoColor(.white))
        leftBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        rightBar.backgroundColor = .color(.dittoLettoColor(.gray2))

        NSLayoutConstraint.activate([
            contentStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            contentStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            headerView.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            headerView.leftAnchor.constraint(equalTo: contentStackView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: contentStackView.rightAnchor),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.037),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.007),
            rightBar.rightAnchor.constraint(
                equalTo: contentStackView.rightAnchor,
                constant: -UIScreen.main.bounds.width * 0.027
            ),
            rightBar.topAnchor.constraint(
                equalTo: headerView.topAnchor,
                constant: UIScreen.main.bounds.height * 0.01
            ),
            rightBar.bottomAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: -UIScreen.main.bounds.height * 0.01
            ),
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.037),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.011),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftBar.rightAnchor.constraint(
                equalTo: rightBar.leftAnchor,
                constant: -UIScreen.main.bounds.width * 0.016
            ),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.074),
            bottomBorderView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomBorderView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: 1),
            bottomBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            rightBorderView.widthAnchor.constraint(equalToConstant: 1),
            rightBorderView.leftAnchor.constraint(equalTo: contentStackView.rightAnchor),
            rightBorderView.topAnchor.constraint(equalTo: self.topAnchor),
            rightBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func setNoticeType() {
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
            bottomBorderView
        }
        [
            contentStackView,
            rightBorderView
        ].forEach { self.addSubview($0) }
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.isUserInteractionEnabled = true

        headerView.backgroundColor = .color(.dittoLettoColor(.third))
        contentView.backgroundColor = .color(.dittoLettoColor(.dark))
        leftBar.backgroundColor = .color(.dittoLettoColor(.dark))
        rightBar.backgroundColor = .color(.dittoLettoColor(.dark))
        headerTitleLabel.textColor = .color(.dittoLettoColor(.white))

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            contentStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            headerView.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            headerView.leftAnchor.constraint(equalTo: contentStackView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: contentStackView.rightAnchor),
            headerTitleLabel.topAnchor.constraint(
                equalTo: headerView.topAnchor,
                constant: UIScreen.main.bounds.height * 0.019
            ),
            headerTitleLabel.bottomAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: -UIScreen.main.bounds.height * 0.019
            ),
            headerTitleLabel.leftAnchor.constraint(
                equalTo: contentStackView.leftAnchor,
                constant: UIScreen.main.bounds.width * 0.042
            ),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.049),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.017),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.rightAnchor.constraint(
                equalTo: contentStackView.rightAnchor,
                constant: -UIScreen.main.bounds.width * 0.042
            ),
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.049),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.009),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftBar.rightAnchor.constraint(
                equalTo: rightBar.leftAnchor,
                constant: -UIScreen.main.bounds.width * 0.04
            ),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
//            contentView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor),
            noticeTextView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: UIScreen.main.bounds.height * 0.029
            ),
            noticeTextView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -UIScreen.main.bounds.height * 0.029
            ),
            noticeTextView.leftAnchor.constraint(
                equalTo: contentStackView.leftAnchor,
                constant: UIScreen.main.bounds.width * 0.042
            ),
            noticeTextView.rightAnchor.constraint(
                equalTo: contentStackView.rightAnchor,
                constant: -UIScreen.main.bounds.width * 0.042
            ),
            bottomBorderView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomBorderView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: 1),
            bottomBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            rightBorderView.widthAnchor.constraint(equalToConstant: 1),
            rightBorderView.leftAnchor.constraint(equalTo: contentStackView.rightAnchor),
            rightBorderView.topAnchor.constraint(equalTo: self.topAnchor),
            rightBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

public extension MyPageContentView {
    func setTextViewSpacing() {
        noticeTextView.setLineAndLetterSpacing(8, .white)
        noticeTextView.font = .ramche(.subheadline)
    }
}
// swiftlint:enable function_body_length
// swiftlint:enable file_length
