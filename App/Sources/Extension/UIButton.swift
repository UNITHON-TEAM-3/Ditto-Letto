import UIKit

public extension UIButton {
    func selectTypeButton(title: String) {
        self.clipsToBounds = true
        self.titleLabel?.font = UIFont(name: "Ramche", size: 17)
        self.setTitle("\(title)", for: .normal)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

    func setEnabled() {
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = UIColor(named: "mainYelloColor") ?? .yellow
    }

    func setDisabled() {
        self.setTitleColor(UIColor(named: "gray2Color"), for: .normal)
        self.backgroundColor = UIColor(named: "mainGrayColor") ?? .lightGray
    }
}
