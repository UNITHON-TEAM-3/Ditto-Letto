//import Foundation
//import UIKit
//import RxSwift
//import RxCocoa
//import Moya
//import RxMoya
//
//// swiftlint:disable line_length
//final class Service {
//    let provider = MoyaProvider<API>(plugins: [MoyaLoggingPlugin()])
//
//    func setNetworkError(_ error: Error) -> NetworkingResult {
//            print(error)
//            print(error.localizedDescription)
//            guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
//            return (NetworkingResult(rawValue: status) ?? .fault)
//    }
//}
