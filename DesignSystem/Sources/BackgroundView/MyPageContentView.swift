import UIKit

public final class MyPageContentView: UIView {
    private let headerView: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.third))
        return $0
    }(UIView())
    private let leftBar: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UIView())
    private let rightBar: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UIView())
    private let contentView: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.gray1))
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

    init(
        leftBarWidth: CGFloat,
        leftBarHeight: CGFloat,
        rightBarWidth: CGFloat,
        rightBarHeight: CGFloat
    ) {
        super.init(frame: .zero)

        leftBar.translatesAutoresizingMaskIntoConstraints = false
        rightBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            leftBar.widthAnchor.constraint(equalToConstant: leftBarWidth),
            leftBar.heightAnchor.constraint(equalToConstant: leftBarHeight),
            rightBar.widthAnchor.constraint(equalToConstant: rightBarWidth),
            rightBar.heightAnchor.constraint(equalToConstant: rightBarHeight)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
