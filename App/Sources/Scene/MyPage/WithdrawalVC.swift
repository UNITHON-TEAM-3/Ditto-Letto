import UIKit
import RxSwift
import RxCocoa
import DesignSystem

class WithdrawalVC: BaseVC {
    private let contentView = MyPageContentView(.notice)
    private let selectTableView = UITableView().then {
        $0.register(WithdrawalCell.self, forCellReuseIdentifier: "WithdrawalCell")
        $0.separatorInset.left = 0
        $0.separatorInset.right = 0
        $0.separatorColor = .color(.dittoLettoColor(.white))
        $0.allowsMultipleSelection = false
    }
    private let sendButton = UIButton().then {
        $0.setTitle("탈퇴하기", for: .normal)
        $0.setMainButton(color: .gray1)
    }

    override func addView() {
        self.view.addSubview(contentView)
        [
            contentView,
            selectTableView
        ].forEach {
            view.addSubview($0)
        }
    }

    override func bind() {
        sendButton.rx.tap
            .subscribe(onNext: {
                let alert = AlertView(delegate: self, alertType: .yesNo)
                self.present(alert, animated: true)
            }).disposed(by: disposeBag)
    }

    override func configureVC() {
        contentView.headerText = "탈퇴 신청 전 확인해주세요."
        contentView.textViewText = """
        탈퇴 이후 회원 정보 및 이용기록은 모두 삭제되며,
        여러분의 설레이는 편지는 다시 복구할 수 없어요.

        정말 탈퇴하시겠어요?
        ㅇㅠ^ㅠㅇ
        """
        contentView.setTextViewSpacing()
    }

    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.snp.centerY).offset(-UIScreen.main.bounds.height * 0.35)
        }
        selectTableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
    }
}

extension WithdrawalVC: AlertDelegate {
    func exit() {
        self.dismiss(animated: true)
    }
    func yes() {
        self.dismiss(animated: true)
    }
}
