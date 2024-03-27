import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class DetailLetterVC: BaseVC {
    private var letterID = BehaviorRelay<Int>(value: 0)
    private let isPrivate = BehaviorRelay<Bool>(value: true)
    private var getDetail = BehaviorRelay<Void>(value: ())
    private let deleteLetterViewModel = DeleteLetterVM()
    private let fetchDetailLetterViewModel = FetchDetailLetterVM()

    private let separatorView = UIView().then {
        $0.setSeparatorView()
    }
    private let letterTextField = UITextField().then {
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1.0
        $0.isEnabled = false
    }
    private let letterTextView = UITextView().then {
        $0.layer.borderColor = UIColor.color(.dittoLettoColor(.dark)).cgColor
        $0.layer.borderWidth = 1.0
        $0.backgroundColor = .white
        $0.textColor = .color(.dittoLettoColor(.dark))
        $0.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 54, right: 20)
        $0.isEditable = false
        $0.isSelectable = false
    }
    private let distanceLabel = UILabel().then {
        $0.text = "전송거리"
        $0.textColor = .color(.dittoLettoColor(.dark))
        $0.font = .ramche(.caption1)
    }
    private let transportImage = UIImageView().then {
        $0.backgroundColor = .clear
    }
    private let dateLabel = UILabel().then {
        $0.textColor = .color(.dittoLettoColor(.dark))
    }
    private let deleteButton = UIButton().then {
        $0.setTitle("삭제하기", for: .normal)
        $0.setTitleColor(.color(.dittoLettoColor(.dark)), for: .normal)
        $0.titleLabel?.font = .ramche(.body)
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.color(.dittoLettoColor(.gray2)).cgColor
        $0.layer.borderWidth = 1
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 4
    }
    private let replyButton = UIButton().then {
        $0.setTitle("답장하기", for: .normal)
        $0.setMainButton(color: .main)
    }
    private let sendCountLabel = UILabel().then {
        $0.text = ""
    }
    private let receiveCountLabel = UILabel().then {
        $0.text = ""
    }

    override func addView() {
        [
            sendCountLabel,
            receiveCountLabel
        ].forEach {
            letterTextField.addSubview($0)
        }
        [
            separatorView,
            letterTextField,
            letterTextView,
            deleteButton,
            replyButton
        ].forEach {
            view.addSubview($0)
        }
        [
            distanceLabel,
            transportImage,
            dateLabel
        ].forEach {
            letterTextView.addSubview($0)
        }
    }

    // swiftlint:disable function_body_length
    override func bind() {
        let input = FetchDetailLetterVM.Input(getDetail: getDetail.asDriver(), id: letterID.asDriver())
        let output = fetchDetailLetterViewModel.transform(input)

        output.detailLetter.asObservable()
            .subscribe(onNext: { [self] data in
                letterTextField.text = data.from
                letterTextView.text = data.text
                dateLabel.text = data.sentAt

                switch data.type {
                case "CODE":
                    letterTextField.setTextField(true)
                    letterTextView.setLineAndLetterSpacing(8, .dark)
                    letterTextView.font = .ramche(.headline)
                    sendCountLabel.text = "\(data.fromCount)"
                    receiveCountLabel.text = "\(data.toCount)"
                    sendCountLabel.setCount(true)
                    receiveCountLabel.setCount(true)
                    sendCountLabel.snp.updateConstraints {
                        $0.top.equalToSuperview().inset(17)
                        $0.right.equalToSuperview().inset(16)
                    }
                    receiveCountLabel.snp.updateConstraints {
                        $0.bottom.equalToSuperview().inset(17)
                        $0.right.equalToSuperview().inset(16)
                    }
                case "BASIC":
                    letterTextField.setTextField(false)
                    letterTextView.setLineAndLetterSpacing(-3, .dark)
                    letterTextView.font = .yoondongju(.headline)
                    sendCountLabel.text = "\(data.toCount)"
                    receiveCountLabel.text = "\(data.fromCount)"
                    sendCountLabel.setCount(false)
                    receiveCountLabel.setCount(false)
                    sendCountLabel.snp.updateConstraints {
                        $0.top.equalToSuperview().inset(15)
                        $0.right.equalToSuperview().inset(19)
                    }
                    receiveCountLabel.snp.updateConstraints {
                        $0.bottom.equalToSuperview().inset(14)
                        $0.right.equalToSuperview().inset(19)
                    }
                default:
                    print("load failed")
                }

                switch data.mediumType {
                case "WALK":
                    transportImage.image = .Image.walkIcon
                case "RUN":
                    transportImage.image = .Image.runningIcon
                case "BICYCLE":
                    transportImage.image = .Image.bikeIcon
                case "HORSE":
                    transportImage.image = .Image.horseIcon
                case "CAR":
                    transportImage.image = .Image.carIcon
                case "PLAIN":
                    transportImage.image = .Image.airplaneIcon
                default:
                    print("falied")
                }
            }).disposed(by: disposeBag)
    }
    // swiftlint:enable function_body_length
    override func configureVC() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black

        let alert = UIAlertController(
            title: "편지를 정말 삭제하시겠어요?",
            message: "삭제하실 경우, 해당 편지는 다시 확인 및 복원하실 수 없어요.",
            preferredStyle: .alert
        )
        let yesButton = UIAlertAction(title: "네", style: .destructive, handler: { _ in
            let input = DeleteLetterVM.Input(id: self.letterID.asDriver())
            let output = self.deleteLetterViewModel.transform(input)
            output.deleteResult.asObservable()
                .subscribe(onNext: { res in
                    if res {
                        print("successfully deleted")
                    }
                }).disposed(by: self.disposeBag)
        })
        let noButton = UIAlertAction(title: "아니오", style: .default, handler: { _ in
            self.dismiss(animated: true)
        })
        [yesButton, noButton].forEach { alert.addAction($0) }

        self.deleteButton.rx.tap
            .subscribe(onNext: {
                self.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.letterTextView.resignFirstResponder()
    }
    override func setLayout() {
        separatorView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(110)
            $0.height.equalTo(9)
        }
        letterTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(separatorView.snp.bottom).offset(0)
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
            $0.bottom.equalToSuperview().inset(146)
        }
        distanceLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(26)
            $0.width.equalTo(42)
            $0.height.equalTo(16)
        }
        transportImage.snp.makeConstraints {
            $0.left.equalTo(distanceLabel.snp.right).offset(10)
            $0.bottom.equalToSuperview().inset(22)
            $0.width.height.equalTo(20)
        }
        dateLabel.snp.makeConstraints {
            $0.left.equalTo(transportImage.snp.right).offset(50)
            $0.bottom.equalToSuperview().inset(24)
            $0.width.equalTo(70)
        }
        deleteButton.snp.makeConstraints {
            $0.width.equalTo((UIScreen.main.bounds.width-50)/2)
            $0.left.equalToSuperview().inset(20)
            $0.top.equalTo(letterTextView.snp.bottom).inset(16)
        }
        replyButton.snp.makeConstraints {
            $0.width.equalTo((UIScreen.main.bounds.width-50)/2)
            $0.right.equalToSuperview().inset(20)
            $0.top.equalTo(letterTextView.snp.bottom).inset(16)
        }
    }
}
