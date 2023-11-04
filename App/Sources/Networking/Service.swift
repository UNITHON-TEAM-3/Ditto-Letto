import Foundation
import UIKit
import RxSwift
import RxCocoa
import Moya
import RxMoya

// swiftlint:disable superfluous_disable_command line_length
final class Service {
    let provider = MoyaProvider<API>(plugins: [MoyaLoggingPlugin()])

    func setNetworkError(_ error: Error) -> NetworkingResult {
            print(error)
            print(error.localizedDescription)
            guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
            return (NetworkingResult(rawValue: status) ?? .fault)
    }

    func login(_ code: String) -> Single<NetworkingResult> {
        return provider.rx.request(.login(code))
            .map(TokenModel.self)
            .map { response -> NetworkingResult in
                Token.accessToken = response.data.accessToken
                return .getOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }

    func getCount(_ phone: String) -> Single<(CountModel?, NetworkingResult)> {
        return provider.rx.request(.getCount(phone))
            .map(CountModel.self)
            .map { return ($0, .getOk) }
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }

    func postNewLetter(_ text: String, _ type: String, _ targetPhoneNumber: String) -> Single<NetworkingResult> {
        return provider.rx.request(.postNewLetter(text, type, targetPhoneNumber))
            .map { _ -> NetworkingResult in
                return .getOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }

    func fetchDetailLetter(_ id: Int) -> Single<(DetailLetterModel?, NetworkingResult)> {
        return provider.rx.request(.fetchDetailLetter(id))
            .map(DetailLetterModel.self)
            .map { return ($0, .getOk) }
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }

    func deleteLetter(_ id: Int) -> Single<NetworkingResult> {
        return provider.rx.request(.deleteLetter(id))
            .map { _ -> NetworkingResult in
                return .deleteOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }

    func letterMy() -> Single<(LetterMyModel?, NetworkingResult)> {
        return provider.rx.request(.letterMy)
            .map(LetterMyModel.self)
            .map { return ($0, .getOk) }
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
}
// swiftlint:enable superfluous_disable_command line_length
