import UIKit
import RxSwift
import RxCocoa

class MyLetterVM: BaseVM {
    
    let disposeBag = DisposeBag()
    
    let homeModel = BehaviorRelay<[HomeModel]>(value: [])
    
    //MARK: - In/Out
    struct Input {
        let tableViewModelSelected: Observable<HomeModel>
        let sendButtonTapped: Observable<Void>
    }
    struct Output {
        
    }
    
    //MARK: - Translate
    func transform(_ input: Input) -> Output {
        getLetterRequest()
        let output = Output()
        
        input.tableViewModelSelected
            .subscribe {
                // 분기처리: 조회로 연결 & 전송 중
            }
            .disposed(by: disposeBag)
        
        homeModel
            .subscribe { model in
                print(model)
            }
            .disposed(by: disposeBag)
        
        return output
    }
    
    //MARK: API
    func getLetterRequest() {
        let models = [HomeModel(limitedTime: "123123", number: "010-2326-3046", transportation: "car", type: .normal),
                      HomeModel(limitedTime: "213123", number: "010-1234-1234", transportation: "horse", type: .password),
                      HomeModel(limitedTime: "123123", number: "010-2326-3046", transportation: "car", type: .normal),
                      HomeModel(limitedTime: "213123", number: "010-1234-1234", transportation: "horse", type: .password),
                      HomeModel(limitedTime: "123123", number: "010-2326-3046", transportation: "car", type: .normal),
                      HomeModel(limitedTime: "213123", number: "010-1234-1234", transportation: "horse", type: .password)]
        
        homeModel.accept(models)
        print("append 완료")
    }
}
