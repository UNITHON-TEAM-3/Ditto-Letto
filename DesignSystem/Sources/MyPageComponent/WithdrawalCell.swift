import UIKit

public class WithdrawalCell: UITableViewCell {
    public var text: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    public var onTapped: ((String) -> Void)?

    private let backgroundButton: UIButton = {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system))
    private let titleLabel: UILabel = {
        $0.font = .ramche(.body)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .color(.dittoLettoColor(.third))
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backgroundButton)
        backgroundButton.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            backgroundButton.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            backgroundButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            backgroundButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        backgroundButton.addAction(UIAction { [weak self] _ in
            self?.onTapped!(self?.titleLabel.text ?? "")
        }, for: .allTouchEvents)

        self.backgroundColor = .color(.dittoLettoColor(backgroundButton.isHighlighted ? .white : .third))
        titleLabel.textColor = .color(.dittoLettoColor(backgroundButton.isHighlighted ? .dark : .white))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let backgroundView = UIView()
        backgroundView.backgroundColor = .color(.dittoLettoColor(.white))
        self.selectedBackgroundView = backgroundView
        titleLabel.textColor = .color(.dittoLettoColor(selected ? .dark : .white))
    }

    public func cellOnTapped(onTapped: @escaping (String) -> Void) {
        self.onTapped = onTapped
    }
}
