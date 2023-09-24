import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class DetailLetterVC: BaseVC {
    private var letterID = BehaviorRelay<Int>(value: 0)
    private var type = PublishRelay<String>()
    private var getDetail = BehaviorRelay<Void>(value: ())
    private let deleteLetterViewModel = DeleteLetterVM()
    private let fetchDetailLetterViewModel = FetchDetailLetterVM()

    private let separatorView = UIView().then {
        $0.setSeparatorView()
    }
    private let letterTextField = UITextField().then {
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1.0
    }
    private let letterTextView = UITextView().then {
        $0.layer.borderColor = UIColor(named: "dark")?.cgColor
        $0.layer.borderWidth = 1.0
        $0.backgroundColor = .white
        $0.textColor = UIColor(named: "dark")
        $0.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 54, right: 20)
    }
    private let distanceLabel = UILabel().then {
        $0.text = "전송거리"
        $0.textColor = UIColor(named: "dark")
        $0.font = UIFont(name: "Ramche", size: 12)
    }
    private let transportImage = UIImageView().then {
        $0.image = UIImage(named: "")
    }
    private let dateLabel = UILabel().then {
        $0.textColor = UIColor(named: "dark")
        $0.font = UIFont(name: "Ramche", size: 12)
    }
    private let deleteButton = UIButton().then {
        $0.setTitle("삭제하기", for: .normal)
        $0.setTitleColor(UIColor(named: "dark"), for: .normal)
        $0.titleLabel?.font = UIFont(name: "Ramche", size: 16)
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(named: "gray2")?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 4
    }
    private let replyButton = UIButton().then {
        $0.setTitle("답장하기", for: .normal)
        $0.setMainButton(color: "main")
    }
    private let sendCountLabel = UILabel().then {
        $0.text = ""
    }
    private let receiveCountLabel = UILabel().then {
        $0.text = ""
    }

    func setAlert() {
        let alret = UIAlertController(title: "편지를 정말 삭제하시겠어요?", message: "삭제하실 경우, 해당 편지는 다시 확인 및 복원하실 수 없어요.", preferredStyle: .alert)
        let yes = UIAlertAction(title: "네", style: .default, handler: { _ in
            let input = DeleteLetterVM.Input(id: self.letterID.asDriver())
            let output = self.deleteLetterViewModel.transform(input)
            output.deleteResult.asObservable()
                .subscribe(onNext: { [self] in
                    print($0.self)
                }).disposed(by: self.disposeBag)
        })
        let no = UIAlertAction(title: "아니오", style: .destructive, handler: { _ in
            self.dismiss(animated: true)
        })
        
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
            distanceLabel,
            transportImage,
            dateLabel,
            deleteButton,
            replyButton
        ].forEach {
            view.addSubview($0)
        }
    }
    override func bind() {
        let input = FetchDetailLetterVM.Input(getDetail: getDetail.asDriver(), id: letterID.asDriver())
        let output = fetchDetailLetterViewModel.transform(input)

        output.detailLetter.asObservable()
            .subscribe(onNext: { [self] data in
                self.type.accept(data.type)
                switch data.mediumType {
                case "WALK":
                    transportImage.image = UIImage(named: "walkIcon")
                case "RUN":
                    transportImage.image = UIImage(named: "runningIcon")
                case "BICYCLE":
                    transportImage.image = UIImage(named: "bikeIcon")
                case "HORSE":
                    transportImage.image = UIImage(named: "horseIcon")
                case "CAR":
                    transportImage.image = UIImage(named: "carIcon")
                case "PLAIN":
                    transportImage.image = UIImage(named: "airplaneIcon")
                default:
                    print("falied")
                }
            }).disposed(by: disposeBag)
    }
    override func configureVC() {
        letterTextField.isEnabled = false
        letterTextView.isEditable = false
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.letterTextView.resignFirstResponder()
    }
    override func setLayout() {
        separatorView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(15)
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
        }
    }
}
