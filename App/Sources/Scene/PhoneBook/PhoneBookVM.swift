import UIKit
import RxSwift
import RxCocoa

class PhoneBookVM: BaseVM {
    let disposeBag = DisposeBag()

    // MARK: - In/Out
    struct Input {
        let tableViewModelSelected: Observable<IndexPath>
        let settingButtonTapped: Observable<Void>
    }

    struct Output {
        let phoneBookData = BehaviorRelay<[PhoneBookModel]>(value: [
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678")
        ])
        
    }

    // MARK: - Translate
    func transform(_ input: Input) -> Output {
        let api = Service()
        let output = Output()
        input.settingButtonTapped
            .bind { _ in
                print("setting Button Tap")
            }.disposed(by: disposeBag)
        Observable
            .combineLatest(input.tableViewModelSelected, output.phoneBookData)
            .subscribe { indexPath, dataList in
                print("전화번호부 cell - \(indexPath.row)")
            }.disposed(by: disposeBag)
        return output
    }
}
