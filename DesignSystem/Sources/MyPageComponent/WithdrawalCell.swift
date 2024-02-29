import UIKit

public class WithdrawalCell: UITableViewCell {
    public var text: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }

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
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
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
}
