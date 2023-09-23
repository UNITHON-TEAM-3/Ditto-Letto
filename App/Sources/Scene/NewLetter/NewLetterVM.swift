import RxSwift
import RxCocoa
import Foundation

class NewLetterVM: BaseVM {
    private let disposeBag = DisposeBag()

    struct Input {
        let text: Driver<String>
        let type: Driver<String>
        let phone: Driver<String>
        let buttonTapped: Signal<Void>
    }
    
    struct Output {
        let postResult: PublishRelay<Bool>
    }

    func transform(_ input: Input) -> Output {
        let api = Service()
        let postResult = PublishRelay<Bool>()
        let data = Driver.combineLatest(input.text, input.type, input.phone)

        input.buttonTapped.asObservable()
            .withLatestFrom(data)
            .flatMap { text, type, phone in
                api.postNewLetter(text, type, phone)
            }.subscribe(onNext: { res in
                switch res {
                case .getOk:
                    postResult.accept(true)
                default:
                    postResult.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(postResult: postResult)
    }
}
