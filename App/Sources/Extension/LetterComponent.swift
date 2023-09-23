import UIKit
import Then
import SnapKit

extension UIView {
    func setSeparatorView() {
        self.backgroundColor = UIColor(named: "mainYelloColor")
        self.layer.borderColor = UIColor(named: "headerColor")?.cgColor
        self.layer.borderWidth = 1.0
    }
}

extension UITextField {
    func setTextField(_ isPrivate: Bool) {
        let profile = UIImageView().then {
            $0.image = UIImage(named: "ProfileImage")
            $0.tag = 100
        }
        let privateImage = UIImageView().then {
            $0.image = UIImage(named: "PrivateImage")
            $0.tag = 111
        }
        let generalImage = UIImageView().then {
            $0.image = UIImage(named: "GeneralImage")
            $0.tag = 222
        }
        if isPrivate {
            self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 78, height: 76))
            self.leftViewMode = .always
            [profile, privateImage].forEach { self.addSubview($0) }
            profile.snp.makeConstraints {
                $0.width.height.equalTo(50)
                $0.left.equalToSuperview().inset(15)
                $0.centerY.equalToSuperview()
            }
            privateImage.snp.makeConstraints {
                $0.width.equalTo(68)
                $0.height.equalTo(50)
                $0.right.equalToSuperview().inset(13)
                $0.centerY.equalToSuperview()
            }
            generalImage.removeFromSuperview()
            self.backgroundColor = UIColor(named: "headerColor")
            self.attributedPlaceholder = NSAttributedString(string: "번호를 입력해주세요.", attributes: [
                .foregroundColor: UIColor(named: "gray2Color") ?? .gray,
                .font: UIFont(name: "Ramche", size: 17) ?? .systemFont(ofSize: 17)
            ])
            self.font = UIFont(name: "Ramche", size: 17)
            self.textColor = .white
            self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 68, height: 50))
            self.rightViewMode = .always
        } else {
            self.addSubview(generalImage)
            generalImage.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.right.equalToSuperview().inset(15)
                $0.width.equalTo(61)
                $0.height.equalTo(44)
            }
            self.viewWithTag(100)?.removeFromSuperview()
            self.viewWithTag(111)?.removeFromSuperview()
            self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 25))
            self.leftViewMode = ViewMode.always
            self.backgroundColor = .white
            self.attributedPlaceholder = NSAttributedString(string: "번호를 입력해주세요.", attributes: [
                .foregroundColor: UIColor(named: "gray2Color") ?? .gray,
                .font: UIFont(name: "GS", size: 17) ?? .systemFont(ofSize: 17)
            ])
            self.font = UIFont(name: "GS", size: 17)
            self.textColor = .black
        }
    }
}

extension UITextView {
    func setTextView(_ isPrivate: Bool) {
        if isPrivate {
            self.font = UIFont(name: "Ramche", size: 18)
        } else {
            self.font = UIFont(name: "GS", size: 18) ?? .systemFont(ofSize: 18)
        }
    }
}
