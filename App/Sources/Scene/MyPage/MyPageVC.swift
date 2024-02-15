import UIKit
import RxSwift
import RxCocoa
import DesignSystem

class MyPageVC: BaseVC {
    private let contentView = MyPageContentView(.header)
    private let myInfoButton = MyPageMenuButton()
    private let inquiryButton = MyPageMenuButton()
    private let termsButton = MyPageMenuButton()
    private let policyButton = MyPageMenuButton()
    private let signOutButton = MyPageMenuButton()

    override func addView() {
        [
            contentView,
            myInfoButton,
            inquiryButton,
            termsButton,
            policyButton,
            signOutButton
        ].forEach {
            view.addSubview($0)
        }
    }

    override func bind() {
        myInfoButton.rx.tap
            .subscribe(onNext: {
                let next = MyAuthVC()
                next.navigationController?.navigationBar.topItem?.title = "내 정보"
                self.navigationController?.pushViewController(next, animated: true)
            }).disposed(by: disposeBag)
//        inquiryButton.rx.tap
//            .subscribe(onNext: {
//                print("inquiry")
//            }).disposed(by: disposeBag)
        termsButton.rx.tap
            .subscribe(onNext: {
                let next = PolicyVC()
                next.navigationController?.navigationBar.topItem?.title = "이용약관"
                self.navigationController?.pushViewController(next, animated: true)
            }).disposed(by: disposeBag)
        policyButton.rx.tap
            .subscribe(onNext: {
                let next = PolicyVC()
                next.navigationController?.navigationBar.topItem?.title = "개인정보처리방침"
                self.navigationController?.pushViewController(next, animated: true)
            }).disposed(by: disposeBag)
        signOutButton.rx.tap
            .subscribe(onNext: {
                let alert = AlertView(delegate: self, alertType: .yesNo)
                alert.titleLabel.text = "로그아웃 하시겠어요?"
                alert.messageLabel.text = "접속 중인 기기에서 로그아웃 됩니다."
                self.present(alert, animated: true)
            }).disposed(by: disposeBag)
    }

    override func configureVC() {
        contentView.isUserInteractionEnabled = true
        myInfoButton.text = "내 정보"
        inquiryButton.text = "문의하기"
        termsButton.text = "이용약관"
        policyButton.text = "개인정보처리방침"
        signOutButton.text = "로그아웃"
    }

    override func setLayout() {
        let width = UIScreen.main.bounds.width * (0.893 - 0.002)
        let height = UIScreen.main.bounds.height * 0.542 / 5
        let borderWidth = -UIScreen.main.bounds.width * 0.003 / 2
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.snp.centerY).offset(-UIScreen.main.bounds.height * 0.35)
        }
        myInfoButton.snp.makeConstraints {
            $0.top.equalTo(view.snp.centerY).offset(-UIScreen.main.bounds.height * 0.32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(height)
        }
        inquiryButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(myInfoButton.snp.bottom).offset(borderWidth)
            $0.width.equalTo(width)
            $0.height.equalTo(height)
        }
        termsButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(inquiryButton.snp.bottom).offset(borderWidth)
            $0.width.equalTo(width)
            $0.height.equalTo(height)
        }
        policyButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(termsButton.snp.bottom).offset(borderWidth)
            $0.width.equalTo(width)
            $0.height.equalTo(height)
        }
        signOutButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(policyButton.snp.bottom).offset(borderWidth)
            $0.width.equalTo(width)
            $0.height.equalTo(height)
//            $0.bottom.equalToSuperview().offset(-UIScreen.main.bounds.width * 0.002)
        }
    }
}

extension MyPageVC: AlertDelegate {
    func exit() {
        self.dismiss(animated: true)
    }
    func yes() {
        self.dismiss(animated: true)
    }
}
