import UIKit

public class WithdrawalCell: UITableViewCell {
    public var text: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }

    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .ramche(.body)
        return $0
    }(UILabel())

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
//            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 14),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        titleLabel.textColor = .color(.dittoLettoColor(isSelected ? .dark : .white))
        self.backgroundColor = .color(.dittoLettoColor(isSelected ? .white : .third))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
