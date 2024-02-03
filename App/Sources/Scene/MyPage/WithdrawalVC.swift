import UIKit
import RxSwift
import RxCocoa
import DesignSystem

class WithdrawalVC: BaseVC {
    private let contentView = MyPageContentView(.notice)
    private let sendButton = UIButton().then {
        $0.setTitle("전송하기", for: .normal)
        $0.setMainButton(color: .gray1)
    }

    override func addView() {
        self.view.addSubview(contentView)
    }

    override func bind() {
//        contentView.myInfoButton.rx.tap
//            .subscribe(onNext: {
//                print("myInfo")
//            }).disposed(by: disposeBag)
//        contentView.inquiryButton.rx.tap
//            .subscribe(onNext: {
//                print("inquiry")
//            }).disposed(by: disposeBag)
//        contentView.termsButton.rx.tap
//            .subscribe(onNext: {
//                print("terms")
//            }).disposed(by: disposeBag)
//        contentView.policyButton.rx.tap
//            .subscribe(onNext: {
//                print("policy")
//            }).disposed(by: disposeBag)
        sendButton.rx.tap
            .subscribe(onNext: {
                let alert = AlertView(delegate: self, alertType: .yesNo)
                self.present(alert, animated: true)
            }).disposed(by: disposeBag)
    }

    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.snp.centerY).offset(-UIScreen.main.bounds.height * 0.35)
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
