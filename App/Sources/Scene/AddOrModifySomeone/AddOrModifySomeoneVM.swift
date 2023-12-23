import UIKit
import RxSwift
import RxCocoa

class AddOrModifySomeoneVM: BaseVM {
    let disposeBag = DisposeBag()
    let type: AddOrModifySomeoneType
    
    // MARK: Life Cycles
    init(type: AddOrModifySomeoneType) {
        self.type = type
    }
    // MARK: - In/Out
    struct Input {
        let selectedCharacterType: Observable<CharacterType?>
        let nameTextFieldText: Observable<String>
    }

    struct Output {
        let addOrModifyButtonIsEnabled = BehaviorRelay<Bool>(value: false)
    }

    // MARK: - Translate
    func transform(_ input: Input) -> Output {
        let api = Service()
        let output = Output()
        let isTypeValid = BehaviorSubject(value: false)
        let isTextfieldValid = BehaviorSubject(value: false)
        
        input.selectedCharacterType
            .bind { characterType in
                guard characterType != nil else { return }
                isTypeValid.onNext(true)
            }.disposed(by: disposeBag)
        input.nameTextFieldText
            .bind { text in
                text != "" ? isTextfieldValid.onNext(true) : isTextfieldValid.onNext(false)
            }.disposed(by: disposeBag)
        switch type {
        case .add:
            break
        case .modify:
            Observable
                .combineLatest(isTypeValid, isTextfieldValid, resultSelector: { $0 && $1 }
                ).bind { bool in
                    output.addOrModifyButtonIsEnabled.accept(bool)
                }.disposed(by: disposeBag)
        }
        return output
    }
}
