import UIKit

public extension UITextField {
    // swiftlint:disable function_body_length
    func setTextField(_ isPrivate: Bool) {
        let profile: UIImageView = {
            $0.image = .Image.profileImage
            $0.contentMode = .scaleAspectFit
            $0.tag = 100
            return $0
        }(UIImageView())
        let privateImage: UIImageView = {
            $0.image = .Image.privateImage
            $0.contentMode = .scaleAspectFit
            $0.tag = 111
            return $0
        }(UIImageView())
        let generalImage: UIImageView = {
            $0.image = .Image.generalImage
            $0.contentMode = .scaleAspectFit
            $0.tag = 222
            return $0
        }(UIImageView())

        profile.translatesAutoresizingMaskIntoConstraints = false
        privateImage.translatesAutoresizingMaskIntoConstraints = false
        generalImage.translatesAutoresizingMaskIntoConstraints = false

        self.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.11).isActive = true

        if isPrivate {
            [
                profile,
                privateImage
            ].forEach {
                self.addSubview($0)
            }

            NSLayoutConstraint.activate([
                profile.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.133),
                profile.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.133),
                profile.leftAnchor.constraint(equalTo: self.leftAnchor, constant: UIScreen.main.bounds.width * 0.04),
                profile.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                privateImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.181),
                privateImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.657),
                privateImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -UIScreen.main.bounds.width * 0.037),
                privateImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])

//            profile.snp.makeConstraints {
//                $0.width.height.equalTo(UIScreen.main.bounds.width * 0.133)
//                $0.left.equalToSuperview().inset(UIScreen.main.bounds.width * 0.04)
//                $0.centerY.equalToSuperview()
//            }
//            privateImage.snp.makeConstraints {
//                $0.width.equalToSuperview().multipliedBy(0.181)
//                $0.height.equalToSuperview().multipliedBy(0.657)
//                $0.right.equalToSuperview().inset(UIScreen.main.bounds.width * 0.037)
//                $0.centerY.equalToSuperview()
//            }

            self.viewWithTag(222)?.removeFromSuperview()
            self.backgroundColor = .color(.dittoLettoColor(.dark))
            self.attributedPlaceholder = NSAttributedString(
                string: "번호를 입력해주세요.",
                attributes: [
                    .foregroundColor: UIColor.color(.dittoLettoColor(.gray2)),
                    .font: UIFont.ramche(.body)
                ]
            )
            self.font = .ramche(.body)
            self.textColor = .color(.dittoLettoColor(.white))
            self.leftView = UIView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: UIScreen.main.bounds.width * 0.208,
                    height: UIScreen.main.bounds.height * 0.1
                )
            )
            self.leftViewMode = .always
            self.rightView = UIView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: UIScreen.main.bounds.width * 0.181,
                    height: UIScreen.main.bounds.height * 0.1
                )
            )
            self.rightViewMode = .always
        } else {
            self.addSubview(generalImage)

            NSLayoutConstraint.activate([
                generalImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.163),
                privateImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.578),
                privateImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -UIScreen.main.bounds.width * 0.045),
                privateImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
//            generalImage.snp.makeConstraints {
//                $0.centerY.equalToSuperview()
//                $0.right.equalToSuperview().inset(UIScreen.main.bounds.width * 0.045)
//                $0.width.equalToSuperview().multipliedBy(0.163)
//                $0.height.equalToSuperview().multipliedBy(0.578)
//            }
            self.viewWithTag(100)?.removeFromSuperview()
            self.viewWithTag(111)?.removeFromSuperview()

            self.backgroundColor = .color(.dittoLettoColor(.white))
            self.attributedPlaceholder = NSAttributedString(
                string: "번호를 입력해주세요.",
                attributes: [
                    .foregroundColor: UIColor.color(.dittoLettoColor(.gray2)),
                    .font: UIFont.yoondongju(.body)
                ]
            )
            self.font = .yoondongju(.body)
            self.textColor = .black
            self.leftView = UIView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: UIScreen.main.bounds.width * 0.059,
                    height: UIScreen.main.bounds.height * 0.037
                )
            )
            self.leftViewMode = .always
        }
    }
    // swiftlint:enable function_body_length
}
