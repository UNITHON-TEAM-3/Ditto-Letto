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
            $0.height.equalTo(1)
        }
    }
    func addLeftBorder(_ color: UIColor.Colors.Colors) {
        let border = UIView().then {
            $0.backgroundColor = .color(.dittoLettoColor(color))
        }
        self.addSubview(border)
        border.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.width.equalTo(1)
            $0.verticalEdges.equalToSuperview()
        }
    }
    func addRightBorder(_ color: UIColor.Colors.Colors, _ width: CGFloat) {
        let border = UIView().then {
            $0.backgroundColor = .color(.dittoLettoColor(color))
        }
        self.addSubview(border)
        border.snp.makeConstraints {
            $0.right.equalTo(self.snp.right)
            $0.width.equalTo(width)
            $0.verticalEdges.equalToSuperview()
        }
    }
    func addBottomBorder(_ color: UIColor.Colors.Colors, _ height: CGFloat) {
        let border = UIView().then {
            $0.backgroundColor = .color(.dittoLettoColor(color))
        }
        self.addSubview(border)
        border.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(height)
        }
    }
}
