import UIKit
import SnapKit
import Then
import DesignSystem

class MyPageVC: BaseVC {
    private let contentView = MyPageContentView(.notice)

    override func addView() {
        [
            contentView
        ].forEach {
            view.addSubview($0)
        }
    }

    override func configureVC() {
        contentView.noticeTypeHeight = UIScreen.main.bounds.height * 0.372
        contentView.headerTitleLabel.text = "탈퇴 신청 전 확인해주세요."
// Important:: 1.Put Text - 2.Set Spacing - 3.Set Font
        contentView.noticeTextView.text = """

        탈퇴 이후 회원 정보 및 이용기록은 모두 삭제되며,
        여러분의 설레이는 편지는 다시 복구할 수 없어요.

        정말 탈퇴하시겠어요?
        ㅇㅠ^ㅠㅇ

        """
        contentView.noticeTextView.setLineAndLetterSpacing(8, .color(.dittoLettoColor(.white)))
        contentView.noticeTextView.font = .ramche(.subheadline)
    }

    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
    }
}
