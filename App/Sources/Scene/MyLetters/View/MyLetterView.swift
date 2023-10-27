import UIKit
import SnapKit

class MyLetterView: UIView {
    // MARK: - Properties
    private let redButton = MyLetterCircleView(backgroundColor: "bg")
    private let blueButton = MyLetterCircleView(backgroundColor: "third")
    private let yelloButton = MyLetterCircleView(backgroundColor: "main")
    private let title: UILabel = {
        $0.text = "나의 편지함"
        $0.font = DittoLettoFontFamily.Ramche.regular.font(size: 15)
        return $0
    }(UILabel())
    private let line: UIImageView = {
        $0.image = DittoLettoAsset.Image.twoLine.image
        return $0
    }(UIImageView())
    private let scrollIndigatorView: UIView = {
        $0.backgroundColor = .white
        $0.layer.borderColor = DittoLettoAsset.Color.gray2.color.cgColor
        $0.layer.borderWidth = 0.5
        return $0
    }(UIView())
    private let triangleView = MyLetterTriangleView()
    private let reverseTriangleView = MyLetterReverseTriangleView()
    let tableView: UITableView = {
        $0.backgroundColor = .white
        $0.layer.borderColor = DittoLettoAsset.Color.gray2.color.cgColor
        $0.layer.borderWidth = 0.5
        $0.separatorInset.left = 0
        $0.rowHeight = 82
        return $0
    }(UITableView())

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
    override func draw(_ rect: CGRect) {
        triangleView.setNeedsDisplay()
        reverseTriangleView.setNeedsDisplay()
    }

    // MARK: - Set UI
    private func setView() {
        backgroundColor = DittoLettoAsset.Color.gray1.color
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    private func addView() {
        [redButton, blueButton, yelloButton, title, line, scrollIndigatorView, tableView]
            .forEach {
                addSubview($0)
            }
        scrollIndigatorView.addSubview(triangleView)
        scrollIndigatorView.addSubview(reverseTriangleView)
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
        scrollIndigatorView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).inset(-8)
            make.trailing.bottom.equalToSuperview().inset(14)
            make.width.equalTo(18)
        }
        triangleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(14)
        }
        reverseTriangleView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(5)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(14)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(scrollIndigatorView.snp.top)
            make.trailing.equalTo(scrollIndigatorView.snp.leading)
            make.bottom.equalTo(scrollIndigatorView.snp.bottom)
            make.leading.equalToSuperview().inset(14)
        }
    }
}
