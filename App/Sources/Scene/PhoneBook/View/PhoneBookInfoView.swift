import UIKit
import DesignSystem
import SnapKit

class PhoneBookInfoView: UIView {
    // MARK: - Properties
    private let backgroundView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    private let emptyView1: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.bg))
        return $0
    }(UIView())
    private let emptyView2: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.bg))
        return $0
    }(UIView())
    private let emptyView3: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.bg))
        return $0
    }(UIView())
    private let emptyView4: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.bg))
        return $0
    }(UIView())
    private let emptyView5: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.bg))
        return $0
    }(UIView())
    private let emptyView6: UIView = {
        $0.backgroundColor = .color(.dittoLettoColor(.bg))
        return $0
    }(UIView())
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

    // MARK: - Life Cycles
    init() {
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
        addSubview(backgroundView)
        [emptyView1,
         emptyView2,
         emptyView3,
         emptyView4,
         emptyView5,
         emptyView6,
         myNumberLabel,
         numberLabel,
         pencilButton].forEach {
            backgroundView.addSubview($0)
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
}
