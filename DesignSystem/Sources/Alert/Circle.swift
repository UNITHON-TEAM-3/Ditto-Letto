import UIKit

public final class Circle: UIView {
    public init(_ backgroundColor: UIColor.Colors.Colors, _ borderWidth: CGFloat) {
        super.init(frame: .zero)
        self.backgroundColor = .color(.dittoLettoColor(backgroundColor))
        setView(borderWidth)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setView(_ borderWidth: CGFloat) {
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.color(.dittoLettoColor(.gray2)).cgColor
        layer.cornerRadius = 6
    }
}
