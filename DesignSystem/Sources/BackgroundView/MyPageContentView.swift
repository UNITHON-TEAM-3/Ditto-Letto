import UIKit

public enum MyPageViewType: String {
    case table
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

        leftBar.translatesAutoresizingMaskIntoConstraints = false
        rightBar.translatesAutoresizingMaskIntoConstraints = false

        switch type {
        case .table:
            setTableType()
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
        NSLayoutConstraint.activate([
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }
    func setNoticeType() {
        NSLayoutConstraint.activate([
            leftBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            leftBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            leftBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            rightBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            rightBar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            rightBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }
}
