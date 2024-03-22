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
                self.navigationController?.pushViewController(MyAuthVC(), animated: true)
            }).disposed(by: disposeBag)
        inquiryButton.rx.tap
            .subscribe(onNext: {
                if let url = URL(string: "https://forms.gle/WqSComn9WXsNzPqdA") {
                    UIApplication.shared.open(url, options: [:])
                }
            }).disposed(by: disposeBag)
        termsButton.rx.tap
            .subscribe(onNext: {
                let next = PolicyVC()
                next.type = "이용 약관"
                self.navigationController?.pushViewController(next, animated: true)
            }).disposed(by: disposeBag)
        policyButton.rx.tap
            .subscribe(onNext: {
                let next = PolicyVC()
                next.type = "개인정보 처리 방침"
                self.navigationController?.pushViewController(next, animated: true)
            }).disposed(by: disposeBag)
        signOutButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let alert = AlertView(delegate: self, alertType: .yesNo)
                alert.alertTitle = "로그아웃 하시겠어요?"
                alert.alertContent = "접속 중인 기기에서 로그아웃 됩니다."
                self?.present(alert, animated: false)
            }).disposed(by: disposeBag)
    }

    override func configureVC() {
        contentView.isUserInteractionEnabled = true
        myInfoButton.text = "내 정보"
        inquiryButton.text = "문의하기"
        termsButton.text = "이용 약관"
        policyButton.text = "개인정보 처리 방침"
        signOutButton.text = "로그아웃"
    }

    override func setLayout() {
        let height = UIScreen.main.bounds.height * 0.542 / 5
        let borderWidth = -UIScreen.main.bounds.width * 0.003 / 2
        contentView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(view.snp.centerY).offset(-UIScreen.main.bounds.height * 0.35)
        }
        myInfoButton.snp.makeConstraints {
            $0.top.equalTo(view.snp.centerY).offset(-UIScreen.main.bounds.height * 0.32)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(height)
        }
        inquiryButton.snp.makeConstraints {
            $0.top.equalTo(myInfoButton.snp.bottom).offset(borderWidth)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(height)
        }
        termsButton.snp.makeConstraints {
            $0.top.equalTo(inquiryButton.snp.bottom).offset(borderWidth)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(height)
        }
        policyButton.snp.makeConstraints {
            $0.top.equalTo(termsButton.snp.bottom).offset(borderWidth)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(height)
        }
        signOutButton.snp.makeConstraints {
            $0.top.equalTo(policyButton.snp.bottom).offset(borderWidth)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(height)
        }
    }
}

extension MyPageVC: AlertDelegate {
    func exit() {
        self.dismiss(animated: false)
    }
    func yes() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        self.modalPresentationStyle = .fullScreen
        self.present(LoginVC(), animated: false)
    }
}
