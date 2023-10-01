import UIKit
import RxSwift
import RxCocoa

class MyLetterVM: BaseVM {
    let disposeBag = DisposeBag()

    // MARK: - In/Out
    struct Input {
        let tableViewModelSelected: Observable<IndexPath>
        let sendButtonTapped: Observable<Void>
    }

    struct Output {
        let letterMyData = PublishRelay<LetterMyData>()
        let isArrived = PublishRelay<Bool>()
    }

    // MARK: - Translate
    func transform(_ input: Input) -> Output {
        let api = Service()
        let output = Output()

        api.letterMy()
            .subscribe { model, networkResult in
                guard let model = model else { return }

                if networkResult == .getOk {
                    output.letterMyData.accept(model.data)
                }
            }.disposed(by: disposeBag)

        Observable
            .combineLatest(input.tableViewModelSelected, output.letterMyData)
            .subscribe { indexPath, dataList in
                let data = dataList.outBoxLetters[indexPath.row]
                if data.arrived {
                    output.isArrived.accept(true)
                } else {
                    output.isArrived.accept(false)
                }
            }.disposed(by: disposeBag)

        return output
    }
}
