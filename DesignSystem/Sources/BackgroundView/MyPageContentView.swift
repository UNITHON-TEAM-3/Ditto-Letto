import UIKit

public enum MyPageViewType: String {
    case basic
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
        get { textLabel.text ?? "" }
        set { textLabel.text = newValue }
    }
    public var authImage: UIImage {
        get { snsImageView.image ?? UIImage() }
        set { snsImageView.image = newValue }
    }
    public var textViewText: String {
        get { noticeTextView.text ?? "" }
        set { noticeTextView.text = newValue }
    }
    public var contentViewHeight: CGFloat?
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
        $0.layer.borderWidth = UIScreen.main.bounds.width * 0.003
        return $0
    }(UIView())
    public let myInfoButton = MyPageMenuButton()
    public let inquiryButton = MyPageMenuButton()
    public let termsButton = MyPageMenuButton()
    public let policyButton = MyPageMenuButton()
    public let signOutButton = MyPageMenuButton()
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

    public init(_ type: MyPageViewType, _ contentViewHeight: CGFloat? = 0.542) {
        super.init(frame: .zero)
//        self.isUserInteractionEnabled = true
        self.contentViewHeight = contentViewHeight

        switch type {
        case .basic:
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
            contentView
            bottomBorderView
        }
        [
            contentStackView,
            rightBorderView
        ].forEach { self.addSubview($0) }
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.isUserInteractionEnabled = true

        headerView.backgroundColor = .color(.dittoLettoColor(.third))
        contentView.backgroundColor = .color(.dittoLettoColor(.gray1))
        leftBar.backgroundColor = .color(.dittoLettoColor(.dark))
        rightBar.backgroundColor = .color(.dittoLettoColor(.dark))

        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.893),
            headerView.leftAnchor.constraint(equalTo: contentStackView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: contentStackView.rightAnchor),
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
            ),
            contentView.heightAnchor.constraint(
                equalToConstant: UIScreen.main.bounds.height * (contentViewHeight ?? 0.542)
            ),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            bottomBorderView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.002),
            rightBorderView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.002),
            rightBorderView.leftAnchor.constraint(equalTo: contentStackView.rightAnchor),
            rightBorderView.topAnchor.constraint(equalTo: headerView.topAnchor),
            rightBorderView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor)
        ])
    }

    func setTableType() {
        myInfoButton.text = "내 정보"
        inquiryButton.text = "문의하기"
        termsButton.text = "이용약관"
        policyButton.text = "개인정보처리방침"
        signOutButton.text = "로그아웃"
        myInfoButton.isUserInteractionEnabled = true
        inquiryButton.isUserInteractionEnabled = true
        termsButton.isUserInteractionEnabled = true
        policyButton.isUserInteractionEnabled = true
        signOutButton.isUserInteractionEnabled = true

        lazy var contentStackView = VStackView(spacing: 0) {
            ZStackView {
                headerView
                leftBar
                rightBar
            }
            ZStackView {
                contentView
                myInfoButton
                inquiryButton
                termsButton
                policyButton
                signOutButton
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
        contentView.backgroundColor = .color(.dittoLettoColor(.gray1))
        leftBar.backgroundColor = .color(.dittoLettoColor(.dark))
        rightBar.backgroundColor = .color(.dittoLettoColor(.dark))

        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.893),
            headerView.leftAnchor.constraint(equalTo: contentStackView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: contentStackView.rightAnchor),
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
            ),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            myInfoButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            myInfoButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            myInfoButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            inquiryButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            inquiryButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            inquiryButton.topAnchor.constraint(equalTo: myInfoButton.bottomAnchor, constant: -1),
            termsButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            termsButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            termsButton.topAnchor.constraint(equalTo: inquiryButton.bottomAnchor, constant: -1),
            policyButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            policyButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            policyButton.topAnchor.constraint(equalTo: termsButton.bottomAnchor, constant: -1),
            signOutButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            signOutButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            signOutButton.topAnchor.constraint(equalTo: policyButton.bottomAnchor, constant: -1),
            signOutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomBorderView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.002),
            rightBorderView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.002),
            rightBorderView.leftAnchor.constraint(equalTo: contentStackView.rightAnchor),
            rightBorderView.topAnchor.constraint(equalTo: headerView.topAnchor),
            rightBorderView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor)
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
        textLabel.font = .ramche(.subheadline)

        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.893),
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
            textLabel.leftAnchor.constraint(
                equalTo: snsImageView.rightAnchor,
                constant: UIScreen.main.bounds.width * 0.055
            ),
            textLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: UIScreen.main.bounds.height * 0.044
            ),
            textLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -UIScreen.main.bounds.height * 0.044
            ),
//            textLabel.rightAnchor.constraint(
//                equalTo: contentView.rightAnchor,
//                constant: -UIScreen.main.bounds.height * 0.133
//            ),
            bottomBorderView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomBorderView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.002),
            rightBorderView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.002),
            rightBorderView.leftAnchor.constraint(equalTo: contentStackView.rightAnchor),
            rightBorderView.topAnchor.constraint(equalTo: headerView.topAnchor),
            rightBorderView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor)
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
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.48),
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
            bottomBorderView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.002),
            rightBorderView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.002),
            rightBorderView.leftAnchor.constraint(equalTo: contentStackView.rightAnchor),
            rightBorderView.topAnchor.constraint(equalTo: headerView.topAnchor),
            rightBorderView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor)
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
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.893),
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
                constant: UIScreen.main.bounds.width * 0.051
            ),
            noticeTextView.rightAnchor.constraint(
                equalTo: contentStackView.rightAnchor,
                constant: -UIScreen.main.bounds.width * 0.051
            ),
            bottomBorderView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomBorderView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.002),
            rightBorderView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.002),
            rightBorderView.leftAnchor.constraint(equalTo: contentStackView.rightAnchor),
            rightBorderView.topAnchor.constraint(equalTo: headerView.topAnchor),
            rightBorderView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor)
        ])
    }
}
// swiftlint:enable function_body_length
// swiftlint:enable file_length
