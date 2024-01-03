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
        return $0
    }(UIView())
    private let leftBar: UIView = {
        return $0
    }(UIView())
    private let rightBar: UIView = {
        return $0
    }(UIView())
    private let contentView: UIView = {
        return $0
    }(UIView())
    private lazy var contentStackView = VStackView(spacing: 0) {
        ZStackView {
            headerView
            leftBar
            rightBar
        }
        contentView
    }

    public init(
        type: MyPageViewType
    ) {
        super.init(frame: .zero)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        leftBar.translatesAutoresizingMaskIntoConstraints = false
        rightBar.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

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
            leftBar.rightAnchor.constraint(equalTo: rightBar.leftAnchor, constant: 8)
        ])
    }
    func setAuthType() {
        headerView.backgroundColor = .color(.dittoLettoColor(.gray1))
        contentView.backgroundColor = .color(.dittoLettoColor(.white))
        leftBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        rightBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.064),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.061),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.024),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: UIScreen.main.bounds.width * 0.053),
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.061),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.01),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftBar.rightAnchor.constraint(equalTo: rightBar.leftAnchor, constant: UIScreen.main.bounds.width * 0.042)
        ])
    }
    func setNoticeType() {
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
            leftBar.rightAnchor.constraint(equalTo: rightBar.leftAnchor, constant: UIScreen.main.bounds.width * 0.042)
        ])
    }
    func setWithdrawalType() {
        headerView.backgroundColor = .color(.dittoLettoColor(.gray1))
        contentView.backgroundColor = .color(.dittoLettoColor(.white))
        leftBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        rightBar.backgroundColor = .color(.dittoLettoColor(.gray2))
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.03),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.037),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.007),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: UIScreen.main.bounds.width * 0.027),
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.037),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.012),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            leftBar.rightAnchor.constraint(equalTo: rightBar.leftAnchor, constant: UIScreen.main.bounds.width * 0.016)
        ])
    }
}
