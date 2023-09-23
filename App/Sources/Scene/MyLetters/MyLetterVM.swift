import UIKit
import RxSwift
import RxCocoa

class MyLetterVM: BaseVM {
    
    let disposeBag = DisposeBag()
    
    let inBoxLetters = BehaviorRelay<[BoxLetterData]>(value: [])
    let outBoxLetters = BehaviorRelay<[BoxLetterData]>(value: [])
    let api = Service()
    
    //MARK: - In/Out
    struct Input {
        let tableViewModelSelected: Observable<BoxLetterData>
        let sendButtonTapped: Observable<Void>
    }
    struct Output {
        let nextViewController = PublishRelay<BaseVC>()
    }
    
    //MARK: - Translate
    func transform(_ input: Input) -> Output {
        let output = Output()
        
        input.tableViewModelSelected
            .subscribe { model in
                // 분기처리: 조회로 연결 & 전송 중
                guard let model = model.element else { return }
                
                // 도착 상태 true
                if model.arrived {
                    // 보관함으로 이동
                    
                // 도착 상태 false
                } else {
                    // 편지 전송중 화면으로 이동
                }
            }
            .disposed(by: disposeBag)
        
        input.sendButtonTapped
            .subscribe { _ in
                // 편지 작성 화면으로 이동
            }
            .disposed(by: disposeBag)
        
        api.letterMy()
            .subscribe { [weak self] model, networkResult in
                guard let model = model else { return }
                
                if networkResult == .getOk {
                    self?.inBoxLetters.accept(model.data.inBoxLetters)
                    self?.outBoxLetters.accept(model.data.outBoxLetters)
                }
            }
            .disposed(by: disposeBag)
        
        return output
    }
}
