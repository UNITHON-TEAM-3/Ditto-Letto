import UIKit
import DesignSystem
import SnapKit
import RxSwift
import RxCocoa

class MyLetterVC: BaseVC {
    let viewModel = MyLetterVM()

    // MARK: - Properties
    lazy var myLetterView = MyLetterView()
    private let sendButton: UIButton = {
        $0.setTitle("편지 보내기", for: .normal)
        $0.setMainButton(color: .main)
        return $0
    }(UIButton())
    private let emptyView = HomeEmptyView()
    lazy var tableHeaderView = HomeTableHeaderView(
        frame: CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: 95
        )
    )

    // MARK: - Set UI
    override func addView() {
        view.addSubview(myLetterView)
        view.addSubview(sendButton)
        view.addSubview(emptyView)
    }
    override func setLayout() {
        myLetterView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(126)
        }
        sendButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(55)
            make.top.equalTo(myLetterView.snp.bottom).offset(20)
        }
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(myLetterView.tableView.snp.edges)
        }
    }

    // MARK: - bind
    override func bind() {
        let input = MyLetterVM.Input(
            tableViewModelSelected: myLetterView.tableView.rx.itemSelected.asObservable(),
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
            }.disposed(by: disposeBag)

        output.letterMyData
            .do(onNext: { [weak self] data in
                self?.emptyView.isHidden = !data.outBoxLetters.isEmpty
            })
            .map { $0.outBoxLetters }
            .bind(to: myLetterView.tableView.rx.items) { tableView, index, item in
                // headerView에 model 에 새로 분기되는 값 input
                guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: HomeTableViewCell.identifier,
                        for: IndexPath(row: index, section: 0)
                    ) as? HomeTableViewCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.model = item

                return cell
            }.disposed(by: disposeBag)

        output.isArrived
            .bind { [weak self] bool in
                if bool {
                    // 보관함으로 이동
                    let keepRoomVC = KeepingMyLetterVC()
                    self?.navigationController?.pushViewController(keepRoomVC, animated: true)
                } else {
                    // 전송중으로 이동
                    let loadingVC = LoadingLetterVC()
                    self?.navigationController?.pushViewController(loadingVC, animated: true)
                }
            }.disposed(by: disposeBag)
    }
    override func configureVC() {
        navigationController?.isNavigationBarHidden = true
        sendButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(NewLetterVC(), animated: true)
            }).disposed(by: disposeBag)
    }
}
