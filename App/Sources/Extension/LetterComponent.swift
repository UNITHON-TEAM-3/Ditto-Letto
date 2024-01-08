import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import DesignSystem

extension UIView {
    // UIView Tap RxGesture 대신 사용
    var tapObservable: Observable<Void> {
        return rx.methodInvoked(#selector(UIView.touchesEnded(_:with:)))
            .map { _ in }
    }
    func setSeparatorView() {
        self.backgroundColor = .color(.dittoLettoColor(.main))
        self.layer.borderColor = UIColor.color(.dittoLettoColor(.dark)).cgColor
        self.layer.borderWidth = 1.0
    }
    func makeSpringView() -> UIView {
        let springView: UIView = {
            $0.backgroundColor = UIColor.black
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 0.6
            return $0
        }(UIView())
        let grayView: UIView = {
            $0.backgroundColor = .color(.dittoLettoColor(.gray2))
            return $0
        }(UIView())
        springView.addSubview(grayView)
        grayView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.bottom.equalToSuperview().inset(UIScreen.main.bounds.width * 0.01)
        }
        return springView
    }
    // swiftlint:disable function_body_length
    func makePhoneBookIndicatorBackView() -> UIView {
        let backView: UIView = {
            $0.backgroundColor = .color(.dittoLettoColor(.gray1))
            return $0
        }(UIView())
        let lineView1: UIView = {
            $0.backgroundColor = .color(.dittoLettoColor(.gray2))
            return $0
        }(UIView())
        let lineView2: UIView = {
            $0.backgroundColor = .color(.dittoLettoColor(.gray2))
            return $0
        }(UIView())
        let lineView3: UIView = {
            $0.backgroundColor = .color(.dittoLettoColor(.gray2))
            return $0
        }(UIView())
        let lineView4: UIView = {
            $0.backgroundColor = .color(.dittoLettoColor(.gray2))
            return $0
        }(UIView())
        addSubview(backView)
        [
            lineView1,
            lineView2,
            lineView3,
            lineView4
        ].forEach {
            backView.addSubview($0)
        }
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        lineView1.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(backView.snp.trailing).multipliedBy(0.2)
            make.width.equalTo(1)
        }
        lineView2.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(backView.snp.trailing).multipliedBy(0.4)
            make.width.equalTo(1)
        }
        lineView3.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(backView.snp.trailing).multipliedBy(0.6)
            make.width.equalTo(1)
        }
        lineView4.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(backView.snp.trailing).multipliedBy(0.8)
            make.width.equalTo(1)
        }
        return backView
    }
    // swiftlint:enable function_body_length
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

            [
                profile,
                privateImage
            ].forEach { self.addSubview($0) }

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
            self.attributedPlaceholder = NSAttributedString(
                string: "번호를 입력해주세요.",
                attributes: [
                    .foregroundColor: UIColor.color(.dittoLettoColor(.gray2)),
                    .font: UIFont.ramche(.body)
                ]
            )
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
            self.attributedPlaceholder = NSAttributedString(
                string: "번호를 입력해주세요.",
                attributes: [
                    .foregroundColor: UIColor.color(.dittoLettoColor(.gray2)),
                    .font: UIFont.yoondongju(.body)
                ]
            )
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
    
// MARK:  1. Put Text  ->  2. Set Spacing  ->  3. Set Font
// This Function must be written at the second.
    func setLineAndLetterSpacing(_ lineSpacing: CGFloat, _ color: UIColor) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
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
        self.textColor = color
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
