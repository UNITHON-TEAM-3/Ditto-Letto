import UIKit


class MyPageMenuCell: UITableViewCell {
    private let titleLabel: UILabel = {
        $0.textColor = .color(.dittoLettoColor(.dark))
        $0.font = .ramche(.body)
        return $0
    }(UILabel())
    private let cursorImageView: UIImageView = {
        $0.image = .Image.cursor
        return $0
    }(UIImageView())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addView()
        self.setLayout()
    }
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addView() {
        [
            titleLabel,
            cursorImageView
        ].forEach { addSubview($0) }
    }
    func setLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cursorImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cursorImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cursorImageView.heightAnchor.constraint(equalToConstant: 30),
            cursorImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 30)
        ])
    }
}
