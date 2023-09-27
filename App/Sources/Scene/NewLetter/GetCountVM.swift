import RxSwift
import RxCocoa
import Foundation

class GetCountVM: BaseVM {
    private let disposeBag = DisposeBag()

    struct Input {
        let getCount: Driver<Void>
        let phoeNumber: Driver<String>
    }

    struct Output {
        let getResult: PublishRelay<Bool>
        let countData: PublishRelay<CountData>
    }

    func transform(_ input: Input) -> Output {
        let api = Service()
        let getResult = PublishRelay<Bool>()
        let countData = PublishRelay<CountData>()

        input.getCount.asObservable()
            .withLatestFrom(input.phoeNumber)
            .flatMap { phone in
                api.getCount(phone)
            }.subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    getResult.accept(true)
                    countData.accept(data!.data)
                default:
                    print(res)
                    getResult.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(getResult: getResult, countData: countData)
    }
}
