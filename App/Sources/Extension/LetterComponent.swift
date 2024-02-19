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
        self.layer.borderWidth = UIScreen.main.bounds.width * 0.003
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
