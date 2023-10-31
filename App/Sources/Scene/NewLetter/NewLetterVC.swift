import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import DesignSystem

class NewLetterVC: BaseVC {
    private let isPrivate = BehaviorRelay<Bool>(value: true)
    private let countViewModel = GetCountVM()
    private let letterViewModel = NewLetterVM()
    private let getCount = BehaviorRelay<Void>(value: ())
    private let type = BehaviorRelay<String>(value: "CODE")

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
        $0.layer.borderColor = UIColor.color(.dittoLettoColor(.dark)).cgColor
        $0.layer.borderWidth = 1.0
        $0.backgroundColor = .white
        $0.text = "전하고 싶은 말을 입력해주세요."
        $0.textColor = .color(.dittoLettoColor(.gray2))
        $0.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 54, right: 20)
        $0.autocorrectionType = .no
        $0.setLineAndLetterSpacing()
    }
    private let textCountLabel = UILabel().then {
        $0.text = "0 / 144"
        $0.textColor = .color(.dittoLettoColor(.dark))
    }
    private let sendButton = UIButton().then {
        $0.setTitle("전송하기", for: .normal)
        $0.setMainButton(color: .gray1)
    }
    private let sendCountLabel = UILabel().then {
        $0.text = ""
        $0.textAlignment = .left
    }
    private let receiveCountLabel = UILabel().then {
        $0.text = ""
        $0.textAlignment = .left
    }

    override func addView() {
        [
            sendCountLabel,
            receiveCountLabel
        ].forEach {
            letterTextField.addSubview($0)
        }
        [
            privateDiaryButton,
            generalDiaryButton,
            separatorView,
            letterTextField,
            letterTextView,
            textCountLabel,
            sendButton
        ].forEach {
            view.addSubview($0)
        }
    }
    override func bind() {
        letterTextField.rx.text.orEmpty
            .subscribe(onNext: { [self] in
                if $0.count == 11 {
                    let input = GetCountVM.Input(
                        getCount: getCount.asDriver(),
                        phoeNumber: letterTextField.rx.text.orEmpty.asDriver()
                    )
                    let output = countViewModel.transform(input)
                    output.countData
                        .subscribe(onNext: { [self] data in
                            if type.value == "CODE" {
                                self.sendCountLabel.text = "\(data.fromCount)"
                                self.receiveCountLabel.text = "\(data.toCount)"
                            } else {
                                self.sendCountLabel.text = "\(data.toCount)"
                                self.receiveCountLabel.text = "\(data.fromCount)"
                            }
                        }).disposed(by: disposeBag)
                } else if $0.count == 0 {
                    sendButton.backgroundColor = .color(.dittoLettoColor(.gray1))
                }
            }).disposed(by: disposeBag)

        let input = NewLetterVM.Input(
            text: letterTextView.rx.text.orEmpty.asDriver(),
            type: type.asDriver(onErrorJustReturn: ""),
            phone: letterTextField.rx.text.orEmpty.asDriver(),
            buttonTapped: sendButton.rx.tap.asSignal()
        )
        let output = letterViewModel.transform(input)
        output.postResult.asObservable()
            .subscribe(onNext: { res in
                if res {
                    self.navigationController?.popViewController(animated: true)
                }
            }).disposed(by: disposeBag)
    }

    // swiftlint:disable function_body_length
    override func configureVC() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black

        privateDiaryButton.rx.tap
            .subscribe(onNext: {
                self.isPrivate.accept(!self.isPrivate.value)
            }).disposed(by: disposeBag)
        generalDiaryButton.rx.tap
            .subscribe(onNext: {
                self.isPrivate.accept(!self.isPrivate.value)
            }).disposed(by: disposeBag)
        isPrivate
            .subscribe(onNext: { [self] in
                letterTextField.setTextField($0)
                letterTextView.setTextView($0)
                sendCountLabel.setCount($0)
                receiveCountLabel.setCount($0)

                if $0 == true {
                    type.accept("CODE")
                    privateDiaryButton.setEnabled()
                    generalDiaryButton.setDisabled()
                    textCountLabel.font = .ramche(.caption1)

                    sendCountLabel.snp.updateConstraints {
                        $0.top.equalToSuperview().inset(17)
                        $0.right.equalToSuperview().inset(16)
                    }
                    receiveCountLabel.snp.updateConstraints {
                        $0.bottom.equalToSuperview().inset(17)
                        $0.right.equalToSuperview().inset(16)
                    }
                } else {
                    type.accept("BASIC")
                    generalDiaryButton.setEnabled()
                    privateDiaryButton.setDisabled()
                    textCountLabel.font = .yoondongju(.caption)

                    sendCountLabel.snp.updateConstraints {
                        $0.top.equalToSuperview().inset(15)
                        $0.right.equalToSuperview().inset(19)
                    }
                    receiveCountLabel.snp.updateConstraints {
                        $0.bottom.equalToSuperview().inset(14)
                        $0.right.equalToSuperview().inset(19)
                    }
                }
            }).disposed(by: disposeBag)

        letterTextView.rx.text.orEmpty
            .subscribe(onNext: { [self] in
                textCountLabel.text = "\($0.count) / 144"
                if $0.count > 144 {
                    letterTextView.text = String($0[..<$0.index($0.startIndex, offsetBy: 144)])
                    letterTextView.resignFirstResponder()
                } else if $0.count > 0 && $0.count < 144 {
                    sendButton.backgroundColor = .color(.dittoLettoColor(.main))
                }
                if letterTextView.text == "전하고 싶은 말을 입력해주세요." {
                    textCountLabel.text = "0/144"
                    sendButton.backgroundColor = .color(.dittoLettoColor(.gray1))
                }
            }).disposed(by: disposeBag)
        letterTextView.rx.didBeginEditing
            .bind(onNext: { [self] in
                if letterTextView.text == "전하고 싶은 말을 입력해주세요." {
                    letterTextView.text = ""
                    letterTextView.textColor = .color(.dittoLettoColor(.dark))
                }
            }).disposed(by: disposeBag)
        letterTextView.rx.didEndEditing
            .bind(onNext: { [self] in
                if letterTextView.text == "" {
                    letterTextView.text = "전하고 싶은 말을 입력해주세요."
                    letterTextView.textColor = .color(.dittoLettoColor(.gray2))
                    sendButton.backgroundColor = .color(.dittoLettoColor(.gray1))
                }
            }).disposed(by: disposeBag)
    }
    // swiftlint:enable function_body_length
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.letterTextView.resignFirstResponder()
    }
    override func setLayout() {
        privateDiaryButton.snp.makeConstraints {
            $0.width.equalTo((UIScreen.main.bounds.width-40)/2)
            $0.height.equalTo(43)
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        generalDiaryButton.snp.makeConstraints {
            $0.height.equalTo(43)
            $0.leading.equalTo(privateDiaryButton.snp.trailing).offset(0)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        separatorView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(privateDiaryButton.snp.bottom)
            $0.height.equalTo(9)
        }
        letterTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(separatorView.snp.bottom)
            $0.height.equalTo(76)
        }
        sendCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.right.equalToSuperview().inset(16)
        }
        receiveCountLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(17)
            $0.right.equalToSuperview().inset(16)
        }
        letterTextView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(letterTextField.snp.bottom).offset(0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(120)
        }
        textCountLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(40)
            $0.height.equalTo(16)
            $0.bottom.equalTo(letterTextView.snp.bottom).inset(22)
        }
        sendButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalTo(letterTextView.snp.bottom).offset(14)
            $0.height.equalTo(55)
        }
    }
}
