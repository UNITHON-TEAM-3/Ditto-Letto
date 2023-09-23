import UIKit

import SnapKit
import RxSwift
import RxCocoa

class MyLetterVC: BaseVC {
    
    let viewModel = MyLetterVM()
    
    //MARK: - Properties
    lazy var myLetterView = MyLetterView()
    
    private let sendButton: UIButton = {
        $0.setTitle("편지 보내기", for: .normal)
        $0.setMainButton(color: "main")
        return $0
    }(UIButton())
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Set UI
    override func addView() {
        view.addSubview(myLetterView)
        view.addSubview(sendButton)
    }
    
    override func setLayout() {
        myLetterView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(14)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(sendButton.snp.top).inset(-18)
        }
        sendButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(17)
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(60)
        }
    }
    
    //MARK: - bind
    override func bind() {
        let input = MyLetterVM.Input(tableViewItemSelected: myLetterView.tableView.rx.itemSelected.asObservable(),
                                     tableViewModelSelected: myLetterView.tableView.rx.modelSelected(HomeModel.self).asObservable(),
                                     sendButtonTapped: sendButton.rx.tap.asObservable())
        let output = viewModel.transform(input)
        
        
        
    }
    
}
