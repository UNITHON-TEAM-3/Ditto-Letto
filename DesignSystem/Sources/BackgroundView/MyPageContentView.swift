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
    private lazy var contentStackView = VStackView(spacing: 0) {
        
    }
}
