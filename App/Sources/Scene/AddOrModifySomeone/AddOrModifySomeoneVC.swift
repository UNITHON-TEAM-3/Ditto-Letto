import UIKit
import DesignSystem
import SnapKit
import RxSwift
import RxCocoa

class AddOrModifySomeoneVC: BaseVC {
    // MARK: Properties
    private lazy var phoneBookInfoView: PhoneBookInfoView = {
        switch type {
        case .add:
            let view = PhoneBookInfoView(type: .add)
            view.makeShadowView()
            return view
        case .modify:
            let view = PhoneBookInfoView(type: .modify)
            view.makeShadowView()
            return view
        }
    }()
    private let setCharaterAndNameView = SetCharacterAndNameView()
    private let addOrModifyButton: UIButton = {
        $0.setMainButton(color: .gray2)
        $0.isEnabled = false
        return $0
    }(UIButton())
    private let viewModel: AddOrModifySomeoneVM
    let type: AddOrModifySomeoneType
    // MARK: - Life Cycles
    init(type: AddOrModifySomeoneType, viewModel: AddOrModifySomeoneVM) {
        self.type = type
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        switch type {
        case .add:
            addOrModifyButton.setTitle("추가하기", for: .normal)
        case .modify:
            addOrModifyButton.setTitle("수정하기", for: .normal)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Set UI
    override func addView() {
        [
            phoneBookInfoView,
            setCharaterAndNameView,
            addOrModifyButton
        ].forEach {
            view.addSubview($0)
        }
    }
    override func setLayout() {
        phoneBookInfoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.bounds.height * 0.03)
            make.leading.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.053)
            make.height.equalToSuperview().multipliedBy(0.13)
        }
        addOrModifyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(UIScreen.main.bounds.height * 0.075)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.bounds.height * 0.03)
        }
        setCharaterAndNameView.snp.makeConstraints { make in
            make.leading.equalTo(phoneBookInfoView.snp.leading)
            make.trailing.equalTo(phoneBookInfoView.snp.trailing)
            make.top.equalTo(phoneBookInfoView.snp.bottom).inset(-(UIScreen.main.bounds.height * 0.022))
            make.bottom.equalTo(addOrModifyButton.snp.top).inset(-(UIScreen.main.bounds.height * 0.025))
        }
    }
    override func bind() {
        let input = AddOrModifySomeoneVM.Input(
            selectedCharacterType: setCharaterAndNameView.selectedCharacterType.asObservable(),
                nameTextFieldText: setCharaterAndNameView.nameTextField.rx.text.orEmpty.asObservable()
        )
        let output = viewModel.transform(input)
        
        output.addOrModifyButtonIsEnabled
            .observe(on: MainScheduler.instance)
            .bind { [weak self] bool in
                bool ? self?.addOrModifyButton.setMainButton(color: .main) : self?.addOrModifyButton.setMainButton(color: .gray2)
                self?.addOrModifyButton.isEnabled = bool
            }.disposed(by: disposeBag)
    }
}
