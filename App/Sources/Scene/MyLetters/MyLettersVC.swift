import UIKit
import DesignSystem
import SnapKit
import RxSwift
import RxCocoa

class MyLetterVC: BaseVC {
    let viewModel = MyLetterVM()
    // MARK: - Properties
    lazy var myLetterView = MyLetterView(identifier: HomeTableViewCell.identifier)
    private let sendButton: UIButton = {
        $0.setTitle("편지 보내기", for: .normal)
        $0.setMainButton(color: .main)
        return $0
    }(UIButton())
    private let emptyView = HomeEmptyView(text: """
            나에게 마음을 전달할 수 있도록\n
            편지를 보내볼까요?
        """)
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.myLetterView.setIndicatorSize()
    }
    // MARK: - Set UI
    override func addView() {
        view.addSubview(sendButton)
        view.addSubview(myLetterView)
    }
    override func setLayout() {
        sendButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(UIScreen.main.bounds.height * 0.075)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.bounds.height * 0.03)
        }
        myLetterView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.104)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.bottom.equalTo(sendButton.snp.top).inset(-(UIScreen.main.bounds.height * 0.02))
        }
    }
    override func configureVC() {
        myLetterView.tableView.backgroundView = emptyView
        sendButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(NewLetterVC(), animated: true)
            }).disposed(by: disposeBag)
    }
    // MARK: - bind
    override func bind() {
        let input = MyLetterVM.Input(
            tableViewModelSelected: myLetterView.tableView.rx.itemSelected.asObservable(),
            sendButtonTapped: sendButton.rx.tap.asObservable())
        let output = viewModel.transform(input)
        // 커스텀 스크롤 바
        myLetterView.tableView.rx.contentOffset
            .observe(on: MainScheduler.instance)
            .bind { [weak self] contentOffset in
                guard let topInset = self?.myLetterView.tableView.contentInset.top,
                      let bottomInset = self?.myLetterView.tableView.contentInset.bottom,
                      let contentHeight = self?.myLetterView.tableView.contentSize.height else { return }
                let scroll = contentOffset.y + topInset
                let height = contentHeight + topInset + bottomInset
                let scrollRatio = scroll / height
                self?.myLetterView.indicatorView.topOffsetRatio = scrollRatio
            }.disposed(by: disposeBag)
        output.letterMyData
            .do(onNext: { [weak self] data in
                self?.myLetterView.tableView.backgroundView?.isHidden = !data.outBoxLetters.isEmpty
            })
            .map { $0.outBoxLetters }
            .bind(to: myLetterView.tableView.rx.items) { tableView, index, item in
                // headerView에 model 에 새로 분기되는 값 input
                guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: HomeTableViewCell.identifier,
                        for: IndexPath(row: index, section: 0)
                    ) as? HomeTableViewCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.delegate = self
                cell.model = item
                return cell
            }.disposed(by: disposeBag)
        output.isArrived
            .bind { [weak self] bool in
                if bool {
                    // 보관함으로 이동
                    self?.navigationController?.pushViewController(LetterStorageVC(), animated: true)
                } else {
                    // 전송중으로 이동
                    self?.navigationController?.pushViewController(LoadingLetterVC(), animated: true)
                }
            }.disposed(by: disposeBag)
    }
}
extension MyLetterVC: HomeTableViewCellDelegate {
    func replyButtonTap() {
        print("replyButton Tap")
    }
}
