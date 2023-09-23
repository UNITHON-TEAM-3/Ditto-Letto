import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class NewLetterVC: BaseVC {
    private var isPrivate = BehaviorRelay<Bool>(value: true)

    private let privateDiaryButton = UIButton().then {
        $0.selectTypeButton(title: "암호 편지")
    }
    private let generalDiaryButton = UIButton().then {
        $0.selectTypeButton(title: "일반 편지")
    }
    private let separatorView = UIView().then {
        $0.setSeparatorView()
    }
    private let letterTextField = UITextField().then {
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1.0
    }
    private let letterTextView = UITextView().then {
        $0.layer.borderColor = UIColor(named: "headerColor")?.cgColor
        $0.layer.borderWidth = 1.0
        $0.backgroundColor = .white
        $0.text = "전하고 싶은 말을 입력해주세요."
        $0.textColor = UIColor(named: "gray2Color")
        $0.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 54, right: 20)
    }
    private let textCountLabel = UILabel().then {
        $0.text = "0 / 144"
        $0.textColor = UIColor(named: "headerColor")
    }

    override func addView() {
        [
            privateDiaryButton,
            generalDiaryButton,
            separatorView,
            letterTextField,
            letterTextView,
            textCountLabel
        ].forEach {
            view.addSubview($0)
        }
    }
    override func configureVC() {
        isPrivate
            .subscribe(onNext: {
                self.letterTextField.setTextField($0)
                self.letterTextView.setTextView($0)
                if $0 == true {
                    self.privateDiaryButton.setEnabled()
                    self.generalDiaryButton.setDisabled()
                    self.textCountLabel.font = UIFont(name: "Ramche", size: 12)
                } else {
                    self.generalDiaryButton.setEnabled()
                    self.privateDiaryButton.setDisabled()
                    self.textCountLabel.font = UIFont(name: "GS", size: 12)
                }
            }).disposed(by: disposeBag)
        letterTextView.rx.text.orEmpty
            .subscribe(onNext: { [self] in
                textCountLabel.text = "\($0.count) / 144"
                if $0.count > 144 {
                    letterTextView.text = String($0[..<$0.index($0.startIndex, offsetBy: 144)])
                    letterTextView.resignFirstResponder()
                }
                if letterTextView.text == "전하고 싶은 말을 입력해주세요." {
                    textCountLabel.text = "0/144"
                }
            }).disposed(by: disposeBag)
        letterTextView.rx.didBeginEditing
            .bind(onNext: { [self] in
                if letterTextView.text == "전하고 싶은 말을 입력해주세요." {
                    letterTextView.text = ""
                    letterTextView.textColor = UIColor(named: "headerColor")
                }
            }).disposed(by: disposeBag)
        letterTextView.rx.didEndEditing
            .bind(onNext: { [self] in
                if letterTextView.text == "" {
                    letterTextView.text = "전하고 싶은 말을 입력해주세요."
                    letterTextView.textColor = UIColor(named: "gray2Color")
                }
            }).disposed(by: disposeBag)
        privateDiaryButton.rx.tap
            .subscribe(onNext: {
                self.isPrivate.accept(!self.isPrivate.value)
            }).disposed(by: disposeBag)
        generalDiaryButton.rx.tap
            .subscribe(onNext: {
                self.isPrivate.accept(!self.isPrivate.value)
            }).disposed(by: disposeBag)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.letterTextView.resignFirstResponder()
    }
    override func setLayout() {
        privateDiaryButton.snp.makeConstraints {
            $0.width.equalTo((UIScreen.main.bounds.width-40)/2)
            $0.height.equalTo(43)
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(91)
        }
        generalDiaryButton.snp.makeConstraints {
            $0.height.equalTo(43)
            $0.leading.equalTo(privateDiaryButton.snp.trailing).offset(0)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(91)
        }
        separatorView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(privateDiaryButton.snp.bottom).offset(0)
            $0.height.equalTo(9)
        }
        letterTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(separatorView.snp.bottom).offset(0)
            $0.height.equalTo(76)
        }
        letterTextView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(letterTextField.snp.bottom).offset(0)
            $0.bottom.equalToSuperview().inset(124)
        }
        textCountLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(40)
            $0.height.equalTo(16)
            $0.bottom.equalTo(letterTextView.snp.bottom).inset(22)
        }
    }
}
