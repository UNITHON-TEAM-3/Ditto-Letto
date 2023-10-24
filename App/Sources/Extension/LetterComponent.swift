import UIKit
import Then
import SnapKit

extension UIView {
    func setSeparatorView() {
        self.backgroundColor = DittoLettoAsset.Color.main.color
        self.layer.borderColor = DittoLettoAsset.Color.dark.color.cgColor
        self.layer.borderWidth = 1.0
    }
}

extension UITextField {
    // swiftlint:disable function_body_length
    func setTextField(_ isPrivate: Bool) {
        let profile = UIImageView().then {
            $0.image = DittoLettoAsset.Image.profileImage.image
            $0.tag = 100
        }
        let privateImage = UIImageView().then {
            $0.image = DittoLettoAsset.Image.privateImage.image
            $0.tag = 111
        }
        let generalImage = UIImageView().then {
            $0.image = DittoLettoAsset.Image.generalImage.image
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

            self.backgroundColor = DittoLettoAsset.Color.dark.color
            self.attributedPlaceholder = NSAttributedString(string: "번호를 입력해주세요.", attributes: [
                .foregroundColor: DittoLettoAsset.Color.gray2.color,
                .font: DittoLettoFontFamily.Ramche.regular.font(size: 17)
            ])
            self.font = DittoLettoFontFamily.Ramche.regular.font(size: 17)
            self.textColor = .white
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
                .foregroundColor: DittoLettoAsset.Color.gray2.color,
                .font: DittoLettoFontFamily.YoonDongJu2.regular.font(size: 17)
            ])
            self.font = DittoLettoFontFamily.YoonDongJu2.regular.font(size: 17)
            self.textColor = .black
        }
    }
    // swiftlint:enable function_body_length
}

extension UITextView {
    func setTextView(_ isPrivate: Bool) {
        if isPrivate {
            self.font = DittoLettoFontFamily.Ramche.regular.font(size: 18)
        } else {
            self.font = DittoLettoFontFamily.YoonDongJu2.regular.font(size: 18)
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
        self.textColor = DittoLettoAsset.Color.gray2.color
    }
}

extension UILabel {
    func setCount(_ isPrivate: Bool) {
        if isPrivate {
            self.textColor = .white
            self.font = DittoLettoFontFamily.Ramche.regular.font(size: 12)
        } else {
            self.textColor = .black
            self.font = DittoLettoFontFamily.YoonDongJu2.regular.font(size: 12)
        }
    }
}
