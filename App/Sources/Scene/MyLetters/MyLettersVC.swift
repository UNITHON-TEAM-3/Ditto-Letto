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
    
    private let emptyView = HomeEmptyView()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Set UI
    override func addView() {
        view.addSubview(myLetterView)
        view.addSubview(sendButton)
        view.addSubview(emptyView)
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
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(myLetterView.tableView.snp.edges)
        }
    }
    
    //MARK: - bind
    override func bind() {
        let input = MyLetterVM.Input(
                                    tableViewModelSelected: myLetterView.tableView.rx.modelSelected(HomeModel.self).asObservable(),
                                     sendButtonTapped: sendButton.rx.tap.asObservable())
        let output = viewModel.transform(input)
        
        viewModel.homeModel
            .do(onNext: { [weak self] list in
                self?.emptyView.isHidden = !list.isEmpty
            })
            .bind(to: myLetterView.tableView.rx.items) { tableView, index, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: IndexPath(row: index, section: 0)) as? HomeTableViewCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.model = item
                
                return cell
            }
            .disposed(by: disposeBag)
        
    }
    
}
