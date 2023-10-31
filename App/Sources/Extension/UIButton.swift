import UIKit
import DesignSystem

public extension UIButton {
    func selectTypeButton(title: String) {
        self.clipsToBounds = true
        self.titleLabel?.font = .ramche(.body)
        self.setTitle("\(title)", for: .normal)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

    func setEnabled() {
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = .color(.dittoLettoColor(.main))
    }

    func setDisabled() {
        self.setTitleColor(.color(.dittoLettoColor(.gray2)), for: .normal)
        self.backgroundColor = .color(.dittoLettoColor(.gray1))
    }

    func setMainButton(color: UIColor.Colors.Colors) {
        setTitleColor(.color(.dittoLettoColor(.dark)), for: .normal)
        titleLabel?.font = .ramche(.body)
        backgroundColor = .color(.dittoLettoColor(color))
        layer.borderColor = UIColor.color(.dittoLettoColor(.dark)).cgColor
        layer.borderWidth = 1
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
}
