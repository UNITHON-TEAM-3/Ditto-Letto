import UIKit
import SnapKit
import Then
import DesignSystem

class MyPageVC: BaseVC {
    private let contentview = MyPageContentView(type: .table)

    override func addView() {
        [
            contentview
        ].forEach {
            view.addSubview($0)
        }
    }
    
}
