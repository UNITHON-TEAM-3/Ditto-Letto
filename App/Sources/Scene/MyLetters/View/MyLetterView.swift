import UIKit

import DesignSystem
import SnapKit

class MyLetterView: UIView {
    // MARK: - Properties
    private let redButton = Circle(.bg, 1, 6)
    private let blueButton = Circle(.third, 1, 6)
    private let yelloButton = Circle(.main, 1, 6)
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
        $0.layer.borderWidth = 0.5
        $0.separatorInset.left = 0
        $0.showsVerticalScrollIndicator = false
        $0.rowHeight = UITableView.automaticDimension
        return $0
    }(UITableView())
    var indicatorView = IndicatorView()

    // MARK: - Life Cycles
    init(identifier: String) {
        super.init(frame: .zero)
        setView()
        addView()
        setTableView(identifier: identifier)
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
        [redButton, blueButton, yelloButton, title, line, tableView, indicatorView]
            .forEach {
                addSubview($0)
            }
    }
    private func setTableView(identifier: String) {
        if identifier == HomeTableViewCell.identifier {
            tableView.register(HomeTableViewCell.self, 
                               forCellReuseIdentifier: HomeTableViewCell.identifier)
        }
        if identifier == LetterStorageTableViewCell.identifier {
            tableView.register(LetterStorageTableViewCell.self,
                               forCellReuseIdentifier: LetterStorageTableViewCell.identifier)
        }
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
            make.top.equalToSuperview().inset(34)
            make.leading.bottom.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(32)
        }
        indicatorView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.top)
            make.trailing.equalToSuperview().inset(14)
            make.leading.equalTo(tableView.snp.trailing)
            make.bottom.equalTo(tableView.snp.bottom)
        }
    }
    func setIndicatorSize() {
        let tableHeight = tableView.bounds.height
        let contentHeight = tableView.contentSize.height
        let insetTop = tableView.contentInset.top
        let insetBottom = tableView.contentInset.bottom
        let allHeight = contentHeight + insetTop + insetBottom // 실제로 보여지는 tableView의 콘텐츠 높이
        if allHeight < tableHeight { return } // 콘텐츠 사이즈가 테이블 뷰 컨텐츠 사이즈보다 작을 시
        let heightRatio = min(1.0, tableHeight / allHeight) // 높이 비율을 계산
        indicatorView.heightRatio = heightRatio
        indicatorView.layoutIfNeeded()
    }
}
