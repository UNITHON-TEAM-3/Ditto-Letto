import UIKit

import SnapKit
import RxSwift
import RxCocoa

class KeepingMyLetterVC: BaseVC {
    let keepingLetterView = KeepingLetterView()
    lazy var myLetterView = MyLetterView()

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Set UI
    override func addView() {
        view.addSubview(keepingLetterView)
        view.addSubview(myLetterView)
    }

    override func setLayout() {
        keepingLetterView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(14)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(90)
        }
        myLetterView.snp.makeConstraints { make in
            make.top.equalTo(keepingLetterView.snp.bottom).inset(-13)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    override func configureVC() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    // MARK: - Bind
    override func bind() {
        
    }
    
}
