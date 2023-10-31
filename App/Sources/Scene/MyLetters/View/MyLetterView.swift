import UIKit
import SnapKit
import DesignSystem

class MyLetterView: UIView {
    // MARK: - Properties
    private let redButton = MyLetterCircleView(backgroundColor: .bg)
    private let blueButton = MyLetterCircleView(backgroundColor: .third)
    private let yelloButton = MyLetterCircleView(backgroundColor: .main)
    private let title: UILabel = {
        $0.text = "나의 편지함"
        $0.font = .ramche(.caption1)
        return $0
    }(UILabel())
    private let line: UIImageView = {
        $0.image = .Image.twoLine
        return $0
    }(UIImageView())
    let tableView: UITableView = {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.color(.dittoLettoColor(.gray2)).cgColor
        $0.layer.borderWidth = 1
        $0.separatorInset.left = 0
        $0.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        $0.rowHeight = 110
        return $0
    }(UITableView())

    // MARK: - Life Cycles
    init() {
        super.init(frame: .zero)
        setView()
        addView()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Set UI
    private func setView() {
        backgroundColor = .color(.dittoLettoColor(.gray1))
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    private func addView() {
        addSubview(redButton)
        addSubview(blueButton)
        addSubview(yelloButton)
        addSubview(title)
        addSubview(line)
        addSubview(tableView)
    }
    private func setLayout() {
        redButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(11)
            make.leading.equalToSuperview().inset(12)
            make.height.width.equalTo(12)
        }
        blueButton.snp.makeConstraints { make in
            make.centerY.equalTo(redButton.snp.centerY)
            make.leading.equalTo(redButton.snp.trailing).inset(-10)
            make.width.height.equalTo(12)
        }
        yelloButton.snp.makeConstraints { make in
            make.centerY.equalTo(blueButton.snp.centerY)
            make.leading.equalTo(blueButton.snp.trailing).inset(-10)
            make.width.height.equalTo(12)
        }
        title.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(yelloButton.snp.centerY)
        }
        line.snp.makeConstraints { make in
            make.centerY.equalTo(title.snp.centerY)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(11)
            make.width.equalTo(21)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).inset(-8)
            make.leading.trailing.bottom.equalToSuperview().inset(14)
        }
    }
}
