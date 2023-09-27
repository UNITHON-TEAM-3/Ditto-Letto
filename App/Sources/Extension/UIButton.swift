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
        self.backgroundColor = DittoLettoAsset.Color.main.color
    }

    func setDisabled() {
        self.setTitleColor(DittoLettoAsset.Color.gray2.color, for: .normal)
        self.backgroundColor = DittoLettoAsset.Color.gray1.color
    }

    func setMainButton(color: String) {
        setTitleColor(DittoLettoAsset.Color.dark.color, for: .normal)
        titleLabel?.font = DittoLettoFontFamily.Ramche.regular.font(size: 17)
        backgroundColor = UIColor(named: color)
        layer.borderColor = DittoLettoAsset.Color.dark.color.cgColor
        layer.borderWidth = 1
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
}
