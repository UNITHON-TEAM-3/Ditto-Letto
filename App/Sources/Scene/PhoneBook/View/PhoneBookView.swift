import UIKit
import DesignSystem
import SnapKit

class PhoneBookView: UIView {
    // MARK: - Properties
    private let backgroundNoteView: UIView = {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 0.6
        return $0
    }(UIView())
    private lazy var springView1 = makeSpringView()
    private lazy var springView2 = makeSpringView()
    private lazy var springView3 = makeSpringView()
    private lazy var springView4 = makeSpringView()
    private lazy var springView5 = makeSpringView()
    private lazy var springView6 = makeSpringView()
    lazy var indicatorView = PhoneBookIndicatorView()
    let tableView: UITableView = {
        $0.backgroundColor = .white
        $0.separatorInset.left = 0
        $0.showsVerticalScrollIndicator = false
        $0.rowHeight = UITableView.automaticDimension
        $0.register(PhoneBookTableViewCell.self, forCellReuseIdentifier: PhoneBookTableViewCell.identifier)
        return $0
    }(UITableView())
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
        [
            backgroundNoteView,
            springView1,
            springView2,
            springView3,
            springView4,
            springView5,
            springView6
        ].forEach {
            addSubview($0)
        }
        [
            tableView,
            indicatorView
        ].forEach {
            backgroundNoteView.addSubview($0)
        }
    }
    private func setLayout() {
        backgroundNoteView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(UIScreen.main.bounds.width * 0.024)
        }
        springView1.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.05)
            make.leading.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 0.07)
            make.width.equalTo(UIScreen.main.bounds.width * 0.086)
        }
        springView2.snp.makeConstraints { make in
            make.top.equalTo(springView1.snp.bottom).inset(-(UIScreen.main.bounds.height * 0.0374))
            make.leading.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 0.07)
            make.width.equalTo(UIScreen.main.bounds.width * 0.086)
        }
        springView3.snp.makeConstraints { make in
            make.top.equalTo(springView2.snp.bottom).inset(-(UIScreen.main.bounds.height * 0.0748))
            make.leading.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 0.07)
            make.width.equalTo(UIScreen.main.bounds.width * 0.086)
        }
        springView4.snp.makeConstraints { make in
            make.top.equalTo(springView3.snp.bottom).inset(-(UIScreen.main.bounds.height * 0.0374))
            make.leading.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 0.07)
            make.width.equalTo(UIScreen.main.bounds.width * 0.086)
        }
        springView5.snp.makeConstraints { make in
            make.top.equalTo(springView4.snp.bottom).inset(-(UIScreen.main.bounds.height * 0.0748))
            make.leading.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 0.07)
            make.width.equalTo(UIScreen.main.bounds.width * 0.086)
        }
        springView6.snp.makeConstraints { make in
            make.top.equalTo(springView5.snp.bottom).inset(-(UIScreen.main.bounds.height * 0.0374))
            make.leading.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 0.07)
            make.width.equalTo(UIScreen.main.bounds.width * 0.086)
        }
        indicatorView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 0.07)
        }
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(springView1.snp.trailing)
            make.trailing.equalTo(indicatorView.snp.leading)
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
