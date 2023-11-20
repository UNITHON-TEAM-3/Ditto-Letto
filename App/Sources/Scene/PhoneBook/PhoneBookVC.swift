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
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Set UI
    override func addView() {
        [phoneBookInfoView, phoneBookView].forEach({
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
    }
    // MARK: - Bind
    override func bind() {
        let input = PhoneBookVM.Input(
            tableViewModelSelected: phoneBookView.tableView.rx.itemSelected.asObservable(),
            settingButtonTapped: phoneBookInfoView.pencilButton.rx.tap.asObservable())
        let output = viewModel.transform(input)
        output.phoneBookData
            .observe(on: MainScheduler.instance)
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
        print("cell button Tap")
    }
}
