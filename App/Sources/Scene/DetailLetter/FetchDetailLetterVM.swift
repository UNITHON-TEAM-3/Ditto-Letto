import RxSwift
import RxCocoa
import Foundation

class FetchDetailLetterVM: BaseVM {
    private let disposeBag = DisposeBag()

    struct Input {
        let getDetail: Driver<Void>
        let id: Driver<Int>
    }

    struct Output {
        let getResult: PublishRelay<Bool>
        let detailLetter: PublishRelay<LetterData>
    }

    func transform(_ input: Input) -> Output {
        let api = Service()
        let getResult = PublishRelay<Bool>()
        let detailLetter = PublishRelay<LetterData>()

        input.getDetail.asObservable()
            .withLatestFrom(input.id)
            .flatMap { id in
                api.fetchDetailLetter(id)
            }.subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    getResult.accept(true)
                    detailLetter.accept(data!.data)
                default:
                    print(res)
                    getResult.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(getResult: getResult, detailLetter: detailLetter)
    }
}
