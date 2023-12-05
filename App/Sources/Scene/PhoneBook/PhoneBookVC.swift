import UIKit
import DesignSystem
import SnapKit
import RxSwift
import RxCocoa

class PhoneBookVC: BaseVC {
    let viewModel = PhoneBookVM()
    // MARK: Properties
    private let phoneBookInfoView: PhoneBookInfoView = {
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 4
        return $0
    }(PhoneBookInfoView())
    private let phoneBookView = PhoneBookView()
    private let emptyView = HomeEmptyView(
        text: """
            나의 전화번호부에  \n
            누구를 저장해볼까요?
        """
    )
    private lazy var phoneBookTableHeaderView = PhoneBookTableHeaderView(
        frame: CGRect(x: 0,
                      y: 0,
                      width: phoneBookView.tableView.bounds.width,
                      height: UIScreen.main.bounds.height * 0.089
                     )
    )
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.phoneBookView.setIndicatorSize()
    }
    // MARK: - Set UI
    override func addView() {
        [phoneBookInfoView, 
         phoneBookView].forEach({
            view.addSubview($0)
        })
    }
    override func setLayout() {
        phoneBookInfoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.bounds.height * 0.03)
            make.leading.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.053)
            make.height.equalTo(UIScreen.main.bounds.height * 0.13)
        }
        phoneBookView.snp.makeConstraints { make in
            make.top.equalTo(phoneBookInfoView.snp.bottom).inset(-(UIScreen.main.bounds.height * 0.037))
            make.leading.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.053)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.bounds.height * 0.036)
        }
    }
    override func configureVC() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        phoneBookView.tableView.tableHeaderView = phoneBookTableHeaderView
        phoneBookView.tableView.backgroundView = emptyView
    }
    // MARK: - Bind
    override func bind() {
        let input = PhoneBookVM.Input(
            tableViewModelSelected: phoneBookView.tableView.rx.itemSelected.asObservable(),
            tableHeaderViewTapped: phoneBookTableHeaderView.tapObservable
        )
        let output = viewModel.transform(input)
        phoneBookInfoView.pencilButton.rx.tap
            .bind {
                print("pencil Tap")
            }.disposed(by: disposeBag)
        phoneBookView.tableView.rx.contentOffset
            .observe(on: MainScheduler.instance)
            .bind { [weak self] contentOffset in
                guard let topInset = self?.phoneBookView.tableView.contentInset.top,
                      let bottomInset = self?.phoneBookView.tableView.contentInset.bottom,
                      let contentHeight = self?.phoneBookView.tableView.contentSize.height else { return }
                let scroll = contentOffset.y + topInset
                let height = contentHeight + topInset + bottomInset
                let scrollRatio = scroll / height
                self?.phoneBookView.indicatorView.topOffsetRatio = scrollRatio
            }.disposed(by: disposeBag)
        output.phoneBookData
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] data in
                self?.phoneBookView.tableView.backgroundView?.isHidden = !data.isEmpty
            })
            .bind(to: phoneBookView.tableView.rx.items) { tableView, index, item in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: PhoneBookTableViewCell.identifier,
                    for: IndexPath(row: index, section: 0)
                ) as? PhoneBookTableViewCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.delegate = self
                cell.model = item
                return cell
            }.disposed(by: disposeBag)
    }
}
// MARK: - PhoneBookTableViewCellDelegate
extension PhoneBookVC: PhoneBookTableViewCellDelegate {
    func settingButtonTap() {
        let sheetView = BottomSheetView()
        sheetView.bottomSheetType = .modifyDelete
        sheetView.delegate = self
        sheetView.modalPresentationStyle = .overFullScreen
        self.present(sheetView, animated: false)
    }
}
// MARK: - BottomSheetDelegate
extension PhoneBookVC: BottomSheetDelegate {
    func save() {
        return
    }
    func modify() {
        print("modi")
    }
    func delete() {
        print("del")
    }
    func number(num: String) {
        return
    }
}
