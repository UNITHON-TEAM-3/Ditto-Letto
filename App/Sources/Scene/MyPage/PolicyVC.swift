import UIKit
import RxSwift
import RxCocoa
import DesignSystem

class PolicyVC: BaseVC {
    private let contentView = MyPageContentView(.header)

    override func addView() {
        self.view.addSubview(contentView)
    }

    override func bind() {
    }

    override func configureVC() {
    }

    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(view.snp.centerY).offset(-UIScreen.main.bounds.height * 0.35)
        }
    }
}
