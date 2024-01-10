import UIKit
import SnapKit
import Then
import DesignSystem

extension UIView {
    func addTopBorder(_ color: UIColor.Colors.Colors) {
        let border = UIView().then {
            $0.backgroundColor = .color(.dittoLettoColor(color))
        }
        self.addSubview(border)
        border.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width * 0.003)
        }
    }
    func addLeftBorder(_ color: UIColor.Colors.Colors) {
        let border = UIView().then {
            $0.backgroundColor = .color(.dittoLettoColor(color))
        }
        self.addSubview(border)
        border.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(self.snp.left)
            $0.width.equalTo(UIScreen.main.bounds.width * 0.003)
            $0.verticalEdges.equalToSuperview()
        }
    }
    func addRightBorder(_ color: UIColor.Colors.Colors, _ rate: CGFloat) {
        let border = UIView().then {
            $0.backgroundColor = .color(.dittoLettoColor(color))
        }
        self.addSubview(border)
        border.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalTo(self.snp.right)
            $0.width.equalTo(UIScreen.main.bounds.width * (0.003 + rate))
            $0.verticalEdges.equalToSuperview()
        }
    }
    func addBottomBorder(_ color: UIColor.Colors.Colors, _ rate: CGFloat) {
        let border = UIView().then {
            $0.backgroundColor = .color(.dittoLettoColor(color))
        }
        self.addSubview(border)
        border.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width * (0.003 + rate))
        }
    }
}
