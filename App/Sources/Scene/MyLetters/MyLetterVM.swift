import UIKit
import RxSwift
import RxCocoa

class MyLetterVM: BaseVM {
    
    let disposeBag = DisposeBag()
    
    
    //MARK: - In/Out
    struct Input {
        let tableViewItemSelected: Observable<IndexPath>
        let tableViewModelSelected: Observable<HomeModel>
        let sendButtonTapped: Observable<Void>
    }
    struct Output {
        
    }
    
    //MARK: - Translate
    func transform(_ input: Input) -> Output {
        let output = Output()
        
        input.tableViewModelSelected
            .subscribe {
                // 분기처리: 조회로 연결 & 전송 중
            }
            .disposed(by: disposeBag)
        
        return output
    }
}
