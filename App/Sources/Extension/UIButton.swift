import UIKit

public extension UIButton {
    func selectTypeButton(title: String) {
        self.clipsToBounds = true
        self.titleLabel?.font = DittoLettoFontFamily.Ramche.regular.font(size: 17)
        self.setTitle("\(title)", for: .normal)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

    func setEnabled() {
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = UIColor(named: "main") ?? .yellow
    }

    func setDisabled() {
        self.setTitleColor(UIColor(named: "gray2"), for: .normal)
        self.backgroundColor = UIColor(named: "gray1") ?? .lightGray
    }

    func setMainButton(color: String) {
        setTitleColor(.black, for: .normal)
        titleLabel?.font = DittoLettoFontFamily.Ramche.regular.font(size: 17)
        backgroundColor = UIColor(named: color)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
}
