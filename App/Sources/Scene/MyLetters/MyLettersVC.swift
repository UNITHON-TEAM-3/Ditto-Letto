import UIKit

import SnapKit
import RxSwift
import RxCocoa

class MyLetterVC: BaseVC {
    let viewModel = MyLetterVM()

    // MARK: - Properties
    lazy var myLetterView = MyLetterView()
    
    private let sendButton: UIButton = {
        $0.setTitle("편지 보내기", for: .normal)
        $0.setMainButton(color: "main")
        return $0
    }(UIButton())

    private let emptyView = HomeEmptyView()

    lazy var tableHeaderView = HomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 95))

    override func configureVC() {
        sendButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(NewLetterVC(), animated: true)
            }).disposed(by: disposeBag)
    }

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetting()
    }

    // MARK: - Set UI
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

    private func tableViewSetting() {
        myLetterView.tableView.delegate = self
    }

    // MARK: - bind
    override func bind() {

        let input = MyLetterVM.Input(tableViewModelSelected: myLetterView.tableView.rx.modelSelected(BoxLetterData.self).asObservable(),
                                     sendButtonTapped: sendButton.rx.tap.asObservable())
        let output = viewModel.transform(input)

        output.letterMyData
            .bind { [weak self] data in
                if data.inBoxLetters.isEmpty {
                    self?.myLetterView.tableView.tableHeaderView = nil
                } else {
                    self?.tableHeaderView.model = data.inBoxLetters.first
                    self?.myLetterView.tableView.tableHeaderView = self?.tableHeaderView
                }
            }
            .disposed(by: disposeBag)
        
        output.letterMyData
            .do(onNext: { [weak self] data in
                self?.emptyView.isHidden = !data.outBoxLetters.isEmpty
            })
                .map { $0.outBoxLetters }
                .bind(to: myLetterView.tableView.rx.items) { tableView, index, item in
                    // headerView에 model 에 새로 분기되는 값 input
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: HomeTableViewCell.identifier,
                        for: IndexPath(row: index, section: 0)) as? HomeTableViewCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    cell.model = item
                    
                    return cell
                }
                .disposed(by: disposeBag)
        
    }

}

extension MyLetterVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
