import UIKit
import DesignSystem
import SnapKit

class PhoneBookInfoView: UIView {
    enum PhoneBookInfoViewType: CaseIterable {
        case normal
        case add
        case modify
    }
    // MARK: - Properties
    private let backgroundView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    private let emptyView1 = UIView()
    private let emptyView2 = UIView()
    private let emptyView3 = UIView()
    private let emptyView4 = UIView()
    private let emptyView5 = UIView()
    private let emptyView6 = UIView()
    private let myNumberLabel: UILabel = {
        $0.text = "나의 번호"
        $0.font = .ramche(.footnote)
        $0.textColor = .color(.dittoLettoColor(.gray2))
        return $0
    }(UILabel())
    private let numberLabel: UILabel = {
        $0.text = "011-1234-5673"
        $0.font = .ramche(.headline)
        $0.textColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UILabel())
    let pencilButton: UIButton = {
        $0.setImage(UIImage(asset: DesignSystemAsset.Image.pen), for: .normal)
        return $0
    }(UIButton())
    private let characterImageView: UIImageView = {
        $0.layer.cornerRadius = 5
        $0.image = .Image.profileImage
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    let numberTextField: UITextField = {
        $0.placeholder = "번호를 입력해주세요."
        $0.keyboardType = .numberPad
        $0.textColor = .black
        $0.font = .ramche(.subheadline)
        return $0
    }(UITextField())
    private let nameLabel: UILabel = {
        $0.text = "내 베프>_<"
        $0.font = .ramche(.subheadline)
        $0.textColor = .color(.dittoLettoColor(.dark))
        return $0
    }(UILabel())
    var type: PhoneBookInfoViewType
    // MARK: - Life Cycles
    init(type: PhoneBookInfoViewType) {
        self.type = type
        super.init(frame: .zero)
        backgroundColor = .clear
        addView()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Set UI
    private func addView() {
        [
            emptyView1,
            emptyView2,
            emptyView3,
            emptyView4,
            emptyView5,
            emptyView6
        ].forEach {
            $0.backgroundColor = .color(.dittoLettoColor(.bg))
        }
        addSubview(backgroundView)
        [
            emptyView1,
            emptyView2,
            emptyView3,
            emptyView4,
            emptyView5,
            emptyView6
        ].forEach {
            backgroundView.addSubview($0)
        }
        switch type {
        case .normal:
            [
                myNumberLabel,
                numberLabel,
                pencilButton
            ].forEach {
                backgroundView.addSubview($0)
            }
        case .add:
            [
                characterImageView,
                numberTextField
            ].forEach {
                backgroundView.addSubview($0)
            }
        case .modify:
            numberLabel.font = .ramche(.caption1)
            [
                characterImageView,
                nameLabel,
                numberLabel
            ].forEach {
                backgroundView.addSubview($0)
            }
        }
    }
    private func setLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        emptyView1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.0135)
            make.width.equalTo(UIScreen.main.bounds.width * 0.04)
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width * 0.156)
        }
        emptyView2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.0135)
            make.width.equalTo(UIScreen.main.bounds.width * 0.04)
            make.leading.equalTo(emptyView1.snp.trailing).offset(UIScreen.main.bounds.width * 0.058)
        }
        emptyView3.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.0135)
            make.width.equalTo(UIScreen.main.bounds.width * 0.04)
            make.leading.equalTo(emptyView2.snp.trailing).offset(UIScreen.main.bounds.width * 0.106)
        }
        emptyView4.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.0135)
            make.width.equalTo(UIScreen.main.bounds.width * 0.04)
            make.leading.equalTo(emptyView3.snp.trailing).offset(UIScreen.main.bounds.width * 0.058)
        }
        emptyView5.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.0135)
            make.width.equalTo(UIScreen.main.bounds.width * 0.04)
            make.leading.equalTo(emptyView4.snp.trailing).offset(UIScreen.main.bounds.width * 0.106)
        }
        emptyView6.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.0135)
            make.width.equalTo(UIScreen.main.bounds.width * 0.04)
            make.leading.equalTo(emptyView5.snp.trailing).offset(UIScreen.main.bounds.width * 0.058)
        }
        switch type {
        case .normal:
            normalTypeLayout()
        case .add:
            addTypeLayout()
        case .modify:
            modifyTypeLayout()
        }
    }
    private func normalTypeLayout() {
        myNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.045)
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width * 0.061)
        }
        numberLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 0.02)
            make.leading.equalTo(myNumberLabel.snp.leading).inset(UIScreen.main.bounds.width * 0.0026)
        }
        pencilButton.snp.makeConstraints { make in
            make.centerY.equalTo(numberLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.049)
            make.width.height.equalTo(UIScreen.main.bounds.width * 0.042)
        }
    }
    private func addTypeLayout() {
        characterImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 0.022)
            make.width.height.equalTo(UIScreen.main.bounds.width * 0.133)
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width * 0.047)
        }
        numberTextField.snp.makeConstraints { make in
            make.centerY.equalTo(characterImageView.snp.centerY)
            make.leading.equalTo(characterImageView.snp.trailing).inset(-(UIScreen.main.bounds.width * 0.03))
            make.trailing.equalToSuperview().inset(UIScreen.main.bounds.width * 0.3)
        }
    }
    private func modifyTypeLayout() {
        characterImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 0.022)
            make.width.height.equalTo(UIScreen.main.bounds.width * 0.133)
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width * 0.047)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.top).inset(UIScreen.main.bounds.height * 0.0045)
            make.leading.equalTo(characterImageView.snp.trailing).inset(-(UIScreen.main.bounds.width * 0.04))
        }
        numberLabel.snp.makeConstraints { make in
            make.bottom.equalTo(characterImageView.snp.bottom).inset(UIScreen.main.bounds.height * 0.0045)
            make.leading.equalTo(characterImageView.snp.trailing).inset(-(UIScreen.main.bounds.width * 0.04))
        }
    }
}
