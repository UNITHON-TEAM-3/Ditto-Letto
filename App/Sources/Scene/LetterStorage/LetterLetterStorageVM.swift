import UIKit

import SnapKit
import RxSwift
import RxCocoa

class LetterStorageVM: BaseVM {
    let disposeBag = DisposeBag()

    // MARK: - In/Out
    struct Input {
        let tableViewModelSelected: Observable<IndexPath>
    }
    struct Output {
        let letterStorageData = BehaviorRelay<[LetterStorageModel]>(value: [
            LetterStorageModel(content: "너랑 지금 정말 가까이 있나봐",
                               transportation: TransportationType.walk.rawValue,
                               date: "2023-10-25"),
            LetterStorageModel(content: "너랑 지금 정말 가까이 있나봐",
                               transportation: TransportationType.bicycle.rawValue,
                               date: "2023-10-24"),
            LetterStorageModel(content: "너랑 지금 정말 가까이 있나봐",
                               transportation: TransportationType.horse.rawValue,
                               date: "2023-10-23")])
    }

    // MARK: - Translate
    func transform(_ input: Input) -> Output {
        let output = Output()
        Observable
            .combineLatest(input.tableViewModelSelected, output.letterStorageData)
            .subscribe { indexPath, dataList in
                print("보관함 cell - \(indexPath.row)")
                // 19_1 상세 편지 화면으로 이동
            }.disposed(by: disposeBag)
        return output
    }
}
