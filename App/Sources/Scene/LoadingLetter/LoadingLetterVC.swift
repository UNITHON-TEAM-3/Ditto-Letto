import UIKit

import SnapKit
import RxSwift
import RxCocoa

class LoadingLetterVC: BaseVC {
    let viewModel = LoadingLetterVM()

    // MARK: - Properties
    private let sendingLabel: UILabel = {
        $0.text = "편지 전송 중"
        $0.font = UIFont(name: "Ramche", size: 22)
        return $0
    }(UILabel())
    
    private let runningLabel: UILabel = {
        $0.text = "서로의 거리만큼 달려가고 있어요!"
        $0.font = UIFont(name: "Ramche", size: 16)
        return $0
    }(UILabel())
    
    private let transportationImageView = UIImageView()
    
    private let windyImageView = UIImageView()
    
    private let transportationState = UIImageView()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBar()
        
    }

    // MARK: - Set UI
    override func addView() {
        view.addSubview(sendingLabel)
        view.addSubview(runningLabel)
        view.addSubview(transportationImageView)
        view.addSubview(windyImageView)
        view.addSubview(transportationState)
    }

    override func setLayout() {
        sendingLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(140)
            make.centerX.equalToSuperview()
        }
        runningLabel.snp.makeConstraints { make in
            make.top.equalTo(sendingLabel.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
        }
        transportationImageView.snp.makeConstraints { make in
            make.top.equalTo(runningLabel.snp.bottom).inset(-50)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(63)
        }
        windyImageView.snp.makeConstraints { make in
            make.trailing.equalTo(transportationImageView.snp.leading).inset(-4)
            make.centerY.equalTo(transportationImageView.snp.centerY)
            make.width.height.equalTo(24)
        }
        transportationState.snp.makeConstraints { make in
            make.top.equalTo(transportationImageView.snp.bottom).inset(-10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
    }
    
    func configureBar() {
        let backButton = UIImage(systemName: "chevron.backward")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let delButton = UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let notiButton = UIBarButtonItem(image: backButton, style: .plain, target: self, action: nil)
        notiButton.title = ""
        let menuButton = UIBarButtonItem(image: delButton, style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = notiButton
        self.navigationItem.rightBarButtonItem = menuButton
        
        notiButton.rx
            .tap
            .bind { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        menuButton.rx
            .tap
            .bind { [ weak self] _ in
                //alert View
                let yesAlert = UIAlertAction(title: "네", style: .default) { _ in
                    self?.navigationController?.popViewController(animated: true)
                }
                let noAlert = UIAlertAction(title: "아니오", style: .cancel)
                let alertController = UIAlertController(title: "전송을 취소 하시겠어요?", message: "취소하신 경우, 작성해주신 내용이 저장 및 전송되지 않아요.", preferredStyle: .alert)
                alertController.addAction(yesAlert)
                alertController.addAction(noAlert)
                self?.present(alertController, animated: true)
            }
            .disposed(by: disposeBag)
    }


    // MARK: - bind
    override func bind() {
        let input = LoadingLetterVM.Input()
        let output = viewModel.transform(input)

        //임시
        transportationImageView.image = UIImage(named: "car")
        transportationState.image = UIImage(named: "state01")
        windyImageView.image = UIImage(named: "windly")
        
    }

}

