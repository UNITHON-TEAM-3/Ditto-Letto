import UIKit
import SnapKit
import Then
import DesignSystem

class BaseTC: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addView()
        self.setLayout()
        self.configureVC()
        self.backgroundColor = .color(.dittoLettoColor(.white))
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addView() {}
    func setLayout() {}
    func configureVC() {}

}
