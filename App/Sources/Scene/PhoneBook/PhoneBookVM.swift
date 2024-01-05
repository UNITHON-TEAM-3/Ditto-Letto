import UIKit
import RxSwift
import RxCocoa

class PhoneBookVM: BaseVM {
    let disposeBag = DisposeBag()

    // MARK: - In/Out
    struct Input {
        let tableViewModelSelected: Observable<IndexPath>
        let tableHeaderViewTapped: Observable<Void>
    }

    struct Output {
        let phoneBookData = BehaviorRelay<[PhoneBookModel]>(value: [
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678"),
            PhoneBookModel(phoneBookImage: "", phoneBookName: "내 베프 ><", phoneBookNumber: "010-1234-5678")
        ])
        let moveToAddOrModiView = BehaviorRelay<UIViewController?>(value: nil)
    }

    // MARK: - Translate
    func transform(_ input: Input) -> Output {
        let api = Service()
        let output = Output()
        input.tableHeaderViewTapped
            .bind { _ in
                // 향후 Coordinator로 연결할거라 임시 output 바인딩
                let addVC = AddOrModifySomeoneVC(type: .add, viewModel: AddOrModifySomeoneVM(type: .add))
                output.moveToAddOrModiView.accept(addVC)
            }.disposed(by: disposeBag)
        Observable
            .combineLatest(input.tableViewModelSelected, output.phoneBookData)
            .subscribe { indexPath, dataList in
                
            }.disposed(by: disposeBag)
        return output
    }
}
