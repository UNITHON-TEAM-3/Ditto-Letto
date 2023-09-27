import RxSwift
import RxCocoa
import Foundation

class DeleteLetterVM: BaseVM {
    private let disposeBag = DisposeBag()

    struct Input {
        let id: Driver<Int>
    }

    struct Output {
        let deleteResult: PublishRelay<Bool>
    }

    func transform(_ input: Input) -> Output {
        let api = Service()
        let deleteResult = PublishRelay<Bool>()

        input.id.asObservable()
            .flatMap { id in
                api.deleteLetter(id)
            }.subscribe(onNext: { res in
                switch res {
                case .deleteOk:
                    deleteResult.accept(true)
                default:
                    print(res)
                    deleteResult.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(deleteResult: deleteResult)
    }
}
