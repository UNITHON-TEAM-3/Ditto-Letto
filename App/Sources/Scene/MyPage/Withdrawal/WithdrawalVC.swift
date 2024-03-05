import UIKit
import RxSwift
import RxCocoa
import DesignSystem

class WithdrawalVC: BaseVC {
    private let contentView = MyPageContentView(.notice)
    private let isFirstStepClear = BehaviorRelay<Bool>(value: false)
    private let answerList = BehaviorRelay<[String]>(value: [
        "아니요, 그냥 사용할게요.", "네, 탈퇴할래요."
    ])
    private let firstStepTableView = ContentWrappingTableView().then {
        $0.register(WithdrawalCell.self, forCellReuseIdentifier: "WithdrawalCell")
        $0.rowHeight = 46
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorColor = .color(.dittoLettoColor(.white))
        $0.allowsMultipleSelection = false
        $0.isScrollEnabled = false
    }
    private let secondStepTableView = ContentWrappingTableView().then {
        $0.register(WithdrawalCell.self, forCellReuseIdentifier: "WithdrawalCell")
        $0.rowHeight = 46
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorColor = .color(.dittoLettoColor(.white))
        $0.allowsMultipleSelection = false
        $0.isScrollEnabled = false
    }
    private let sendButton = UIButton().then {
        $0.setTitle("탈퇴하기", for: .normal)
        $0.setMainButton(color: .gray1)
    }

    override func addView() {
        [
            contentView,
            firstStepTableView
        ].forEach {
            view.addSubview($0)
        }
    }

    override func bind() {
        answerList.bind(to: firstStepTableView.rx.items(
            cellIdentifier: "WithdrawalCell",
            cellType: WithdrawalCell.self
        )) { _, item, cell in
            cell.text = item

            cell.cellOnTapped { [self] title in
                if title == "네, 탈퇴할래요." {
                    answerList.accept([
                        "편지 기록을 삭제하고 싶어요.",
                        "사용 빈도가 낮아요.",
                        "다른 비슷한 서비스를 사용할 거예요.",
                        "이용이 불편하고 장애가 잦아요.",
                        "콘텐츠에 불만이 있어요.",
                        "이 외 다른 이유로 탈퇴하는 거예요."
                    ])
                    fillTheNotices(
                        header: "탈퇴 중...",
                        content: """
                        아쉬워요! ㅠ.ㅠ
                        탈퇴하시는 이유가 무엇인가요?

                        더 나은 서비스의 개선 목적으로 사용할게요.
                        탈퇴 이유는 중복 체크가 가능해요.
                        """
                    )
                }
            }
        }.disposed(by: disposeBag)
        sendButton.rx.tap
            .subscribe(onNext: {
                let alert = AlertView(delegate: self, alertType: .yesNo)
                self.present(alert, animated: true)
            }).disposed(by: disposeBag)
    }

    override func configureVC() {
        fillTheNotices(
            header: "탈퇴 신청 전 확인해주세요.",
            content: """
            탈퇴 이후 회원 정보 및 이용기록은 모두 삭제되며,
            여러분의 설레이는 편지는 다시 복구할 수 없어요.

            정말 탈퇴하시겠어요?
            ㅇㅠ^ㅠㅇ
            """
        )
    }

    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(view.snp.centerY).offset(-UIScreen.main.bounds.height * 0.35)
        }
        firstStepTableView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.bottom).offset(UIScreen.main.bounds.height * 0.094)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
    }
}

extension WithdrawalVC: AlertDelegate {
    func fillTheNotices(header: String, content: String) {
        contentView.headerText = header
        contentView.textViewText = content
        contentView.setTextViewSpacing()
    }
    func exit() {
        self.dismiss(animated: true)
    }
    func yes() {
        self.dismiss(animated: true)
    }
}
