import UIKit
import RxSwift
import RxCocoa
import DesignSystem

class MyAuthVC: BaseVC {
    private let myAuthView = MyPageContentView(.auth)
    private let withdrawalView = MyPageContentView(.withdrawal)
    private let withdrawalButton = UIButton(type: .system).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.setTitle("탈퇴하기", for: .normal)
        $0.setTitleColor(.color(.dittoLettoColor(.dark)), for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.titleLabel?.font = .ramche(.body)
    }

    override func addView() {
        [
            myAuthView,
            withdrawalView,
            withdrawalButton
        ].forEach {
            view.addSubview($0)
        }
    }

    override func configureVC() {
        myAuthView.authImage = .Image.kakaoLogo
        myAuthView.textLabel.text = "ch12345@naver.com"
    }

    override func bind() {
        withdrawalButton.rx.tap
            .subscribe(onNext: {
                print("드디어 탈퇴 버튼이 생겼습니당")
            }).disposed(by: disposeBag)
    }

    override func setLayout() {
        myAuthView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.snp.centerY).offset(-UIScreen.main.bounds.height * 0.35)
        }
        withdrawalView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX).offset(UIScreen.main.bounds.width * 0.208)
            $0.top.equalTo(view.snp.centerY).offset(-UIScreen.main.bounds.height * 0.15)
        }
        withdrawalButton.snp.makeConstraints {
            $0.verticalEdges.equalTo(withdrawalView.contentView.snp.verticalEdges)
            $0.left.equalTo(withdrawalView.contentView.snp.left).offset(UIScreen.main.bounds.width * 0.026)
        }
    }
}
