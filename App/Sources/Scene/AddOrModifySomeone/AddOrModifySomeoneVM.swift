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
        let phoneNumberText: Observable<String>
    }

    struct Output {
        let addOrModifyButtonIsEnabled = BehaviorRelay<Bool>(value: false)
        let formattedPhoneNumberText = BehaviorRelay<String>(value: "")
    }

    // MARK: - Translate
    func transform(_ input: Input) -> Output {
        let api = Service()
        let output = Output()
        let isTypeValid = BehaviorSubject(value: false)
        let isTextfieldValid = BehaviorSubject(value: false)
        
        input.phoneNumberText
            .bind { text in
                let digits = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                var formattedText = ""
                let digitCount = digits.count
                let maxDigits = 11
                let hyphenIndices = [3, 7]
                for txt in 0..<min(digitCount, maxDigits) {
                    if hyphenIndices.contains(txt) {
                        formattedText.append("-")
                    }
                    let index = digits.index(digits.startIndex, offsetBy: txt)
                    formattedText.append(digits[index])
                }
                output.formattedPhoneNumberText.accept(formattedText)
            }.disposed(by: disposeBag)
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
