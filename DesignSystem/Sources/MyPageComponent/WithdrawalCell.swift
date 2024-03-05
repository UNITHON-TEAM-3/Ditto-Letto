import UIKit

public class WithdrawalCell: UITableViewCell {
    public var text: String {
        get { backgroundButton.titleLabel?.text ?? "" }
        set { backgroundButton.setTitle(newValue, for: .normal)}
    }
    public var onTapped: ((String) -> Void)?

    private let backgroundButton: UIButton = {
        $0.setBackgroundColor(.color(.dittoLettoColor(.third)), for: .normal)
        $0.setBackgroundColor(.color(.dittoLettoColor(.white)), for: [.selected, .highlighted])
        $0.setTitleColor(.color(.dittoLettoColor(.white)), for: .normal)
        $0.setTitleColor(.color(.dittoLettoColor(.dark)), for: [.selected, .highlighted])
        $0.titleLabel?.font = .ramche(.body)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system))

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backgroundButton)
        NSLayoutConstraint.activate([
            backgroundButton.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            backgroundButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            backgroundButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        backgroundButton.addAction(UIAction { [weak self] _ in
            self?.onTapped!(self?.backgroundButton.currentTitle ?? "")
        }, for: .allTouchEvents)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func cellOnTapped(onTapped: @escaping (String) -> Void) {
        self.onTapped = onTapped
    }
}
