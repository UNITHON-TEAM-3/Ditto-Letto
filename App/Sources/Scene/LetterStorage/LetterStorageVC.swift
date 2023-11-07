import UIKit

import SnapKit
import RxSwift
import RxCocoa

class LetterStorageVC: BaseVC {
    let viewModel = LetterStorageVM()
    // MARK: Properties
    let keepingLetterView = StorageInfoView()
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
        view.addSubview(keepingLetterView)
        view.addSubview(myLetterView)
    }
    override func setLayout() {
        keepingLetterView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(14)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(90)
        }
        myLetterView.snp.makeConstraints { make in
            make.top.equalTo(keepingLetterView.snp.bottom).inset(-13)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
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
