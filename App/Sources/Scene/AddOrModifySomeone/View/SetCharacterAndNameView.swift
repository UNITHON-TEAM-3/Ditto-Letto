import UIKit
import DesignSystem
import SnapKit
import RxSwift
import RxCocoa

final class SetCharacterAndNameView: UIView {
    // MARK: - Properties
    private let topBarView: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.third))
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 0.8
        return $0
    }(UIView())
    private let topBarDetailView: UIView = {
        $0.backgroundColor = .black
        return $0
    }(UIView())
    private let bodyView: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.gray1))
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        return $0
    }(UIView())
    private let setCharacterLabel: UILabel = {
        $0.text = "캐릭터 설정"
        $0.font = .ramche(.subheadline)
        return $0
    }(UILabel())
    private let setCharacterBackgroundView: UIView = {
        $0.backgroundColor = UIColor.white
        $0.layer.borderColor = UIColor.systemGray3.cgColor //color(.dittoLettoColor(.gray2)).cgColor
        $0.layer.borderWidth = 2
        return $0
    }(UIView())
    private lazy var setCharacterStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 15
        $0.backgroundColor = .clear
        return $0
    }(UIStackView())
    private let setNameLabel: UILabel = {
        $0.text = "이름 설정"
        $0.font = .ramche(.subheadline)
        return $0
    }(UILabel())
    private let setNameTextFieldBackgroundView: UIView = {
        $0.backgroundColor = UIColor.white
        $0.layer.borderColor = UIColor.systemGray3.cgColor //color(.dittoLettoColor(.gray2)).cgColor
        $0.layer.borderWidth = 2
        return $0
    }(UIView())
    let nameTextField: UITextField = {
        $0.font = .ramche(.subheadline)
        $0.textColor = .black
        return $0
    }(UITextField())
    var selectedButton: UIButton?
    let selectedCharacterType = BehaviorRelay<CharacterType?>(value: nil)
    var selectedButtonTapped: ((CharacterType) -> Void)?
    var disposeBag = DisposeBag()
    // MARK: - Life Cycles
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        addView()
        setLayout()
        bind()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Set UI
    private func addView() {
        [
            topBarView, bodyView
        ].forEach {
            addSubview($0)
        }
        topBarView.addSubview(topBarDetailView)
        [
            setCharacterLabel,
            setCharacterBackgroundView,
            setNameLabel,
            setNameTextFieldBackgroundView
        ].forEach {
            bodyView.addSubview($0)
        }
        setCharacterBackgroundView.addSubview(setCharacterStackView)
        setNameTextFieldBackgroundView.addSubview(nameTextField)
    }
    private func setLayout() {
        topBarView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        topBarDetailView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.032)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        bodyView.snp.makeConstraints { make in
            make.top.equalTo(topBarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        setCharacterLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.02)
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width * 0.035)
        }
        setCharacterBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(setCharacterLabel.snp.bottom).inset(-(UIScreen.main.bounds.height * 0.02))
            make.leading.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.03)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        setCharacterStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.035)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        setNameLabel.snp.makeConstraints { make in
            make.top.equalTo(setCharacterBackgroundView.snp.bottom).inset(-(UIScreen.main.bounds.height * 0.03))
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width * 0.035)
        }
        setNameTextFieldBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(setNameLabel.snp.bottom).inset(-(UIScreen.main.bounds.height * 0.02))
            make.leading.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.03)
            make.height.equalToSuperview().multipliedBy(0.17)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.03)
        }
    }
    private func bind() {
        CharacterType.allCases.forEach { type in
            let button: UIButton = {
                let btn = UIButton()
                switch type {
                case .normal:
                    btn.setImage(.Image.normalIcon, for: .normal)
                    btn.setImage(.Image.selectedNormalIcon, for: .selected)
                case .bad:
                    btn.setImage(.Image.badIcon, for: .normal)
                    btn.setImage(.Image.selectedBadIcon, for: .selected)
                case .good:
                    btn.setImage(.Image.goodIcon, for: .normal)
                    btn.setImage(.Image.selectedGoodIcon, for: .selected)
                case .sad:
                    btn.setImage(.Image.sadIcon, for: .normal)
                    btn.setImage(.Image.selectedSadIcon, for: .selected)
                }
                return btn
            }()
            button.rx.tap
                .subscribe(onNext: { [weak self] in
                    self?.selectedButton?.isSelected = false
                    self?.selectedButton = button
                    button.isSelected.toggle()
                    self?.selectedCharacterType.accept(type)
                })
                .disposed(by: disposeBag)
            setCharacterStackView.addArrangedSubview(button)
        }
    }
}
