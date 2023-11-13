import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LetterStorageVC: BaseVC {
    let viewModel = LetterStorageVM()
    // MARK: Properties
    let storageInfoView = StorageInfoView()
    lazy var myLetterView = MyLetterView(identifier: LetterStorageTableViewCell.identifier)
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
        view.addSubview(storageInfoView)
        view.addSubview(myLetterView)
    }
    override func setLayout() {
        storageInfoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.bounds.height * 0.009)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.11)
        }
        myLetterView.snp.makeConstraints { make in
            make.top.equalTo(storageInfoView.snp.bottom).offset(UIScreen.main.bounds.height * 0.019)
            make.leading.equalTo(storageInfoView.snp.leading)
            make.trailing.equalTo(storageInfoView.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.bounds.height * 0.03)
        }
    }
    override func configureVC() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
    }
    // MARK: - Bind
    override func bind() {
        let input = LetterStorageVM.Input(
            tableViewModelSelected: myLetterView.tableView.rx.itemSelected.asObservable())
        let output = viewModel.transform(input)
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
        output.letterStorageData
            .observe(on: MainScheduler.instance)
            .bind(to: myLetterView.tableView.rx.items) { tableView, index, item in
                guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: LetterStorageTableViewCell.identifier,
                        for: IndexPath(row: index, section: 0)
                    ) as? LetterStorageTableViewCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.model = item
                return cell
            }.disposed(by: disposeBag)
    }
}
