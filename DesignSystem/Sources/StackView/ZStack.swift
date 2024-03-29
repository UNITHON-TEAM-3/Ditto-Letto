import UIKit

public final class ZStackView: UIStackView {
    public init(@UIViewSubviewsBuilder views: () -> [UIView]) {
        super.init(frame: .zero)
        let container = UIView()

        views()
            .forEach { container.addSubview($0) }

        addArrangedSubview(container)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
