import UIKit
import RxSwift
import RxCocoa
import DesignSystem

class PolicyVC: BaseVC {
    var type = ""
    private let contentView = MyPageContentView(.header)

    override func addView() {
        self.view.addSubview(contentView)
    }

    override func bind() {
    }

    override func configureVC() {
        switch type {
        case "이용 약관":
            self.navigationController?.navigationBar.topItem?.backButtonTitle = type
        case "개인정보 처리 방침":
            self.navigationController?.navigationBar.topItem?.backButtonTitle = type
        default:
            print("no type")
        }
    }

    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(view.snp.centerY).offset(-UIScreen.main.bounds.height * 0.35)
        }
    }
}
