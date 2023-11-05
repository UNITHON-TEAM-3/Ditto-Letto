import UIKit
import Then
import SnapKit
import DesignSystem

extension UIView {
    func setSeparatorView() {
        self.backgroundColor = .color(.dittoLettoColor(.main))
        self.layer.borderColor = UIColor.color(.dittoLettoColor(.dark)).cgColor
        self.layer.borderWidth = 1.0
    }
}

extension UITextField {
    // swiftlint:disable function_body_length
    func setTextField(_ isPrivate: Bool) {
        let profile = UIImageView().then {
            $0.image = .Image.profileImage
            $0.tag = 100
        }
        let privateImage = UIImageView().then {
            $0.image = .Image.privateImage
            $0.tag = 111
        }
        let generalImage = UIImageView().then {
            $0.image = .Image.generalImage
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

            self.backgroundColor = .color(.dittoLettoColor(.dark))
            self.attributedPlaceholder = NSAttributedString(string: "번호를 입력해주세요.", attributes: [
                .foregroundColor: UIColor.color(.dittoLettoColor(.gray2)),
                .font: UIFont.ramche(.body)
            ])
            self.font = .ramche(.body)
            self.textColor = .color(.dittoLettoColor(.white))
            self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 68, height: 50))
            self.rightViewMode = .always
        } else {
            self.addSubview(generalImage)
            generalImage.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.right.equalToSuperview().inset(17)
                $0.width.equalTo(61)
                $0.height.equalTo(44)
            }
            self.viewWithTag(100)?.removeFromSuperview()
            self.viewWithTag(111)?.removeFromSuperview()
            self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 25))
            self.leftViewMode = ViewMode.always
            self.backgroundColor = .white
            self.attributedPlaceholder = NSAttributedString(string: "번호를 입력해주세요.", attributes: [
                .foregroundColor: UIColor.color(.dittoLettoColor(.gray2)),
                .font: UIFont.yoondongju(.body)
            ])
            self.font = .yoondongju(.body)
            self.textColor = .black
        }
    }
    // swiftlint:enable function_body_length
}

extension UITextView {
    func setTextView(_ isPrivate: Bool) {
        if isPrivate {
            self.font = .ramche(.headline)
        } else {
            self.font = .ramche(.headline)
        }
    }

    func setLineAndLetterSpacing() {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributedString = NSMutableAttributedString(string: self.text)
        attributedString.addAttribute(
            NSAttributedString.Key.kern,
            value: CGFloat(0),
            range: NSRange(location: 0, length: attributedString.length)
        )
        attributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: style,
            range: NSRange(location: 0, length: attributedString.length)
        )
        self.attributedText = attributedString
        self.textColor = .color(.dittoLettoColor(.gray2))
    }
}

extension UILabel {
    func setCount(_ isPrivate: Bool) {
        if isPrivate {
            self.textColor = .white
            self.font = .ramche(.caption1)
        } else {
            self.textColor = .black
            self.font = .yoondongju(.caption)
        }
    }
}
