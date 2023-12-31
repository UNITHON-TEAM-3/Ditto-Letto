import Foundation
import Moya

enum API {
    case login(_ code: String)
    case getCount(_ phone: String)
    case postNewLetter(_ text: String, _ type: String, _ targetPhoneNumber: String)
    case fetchDetailLetter(_ id: Int)
    case deleteLetter(_ id: Int)
    case letterMy
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://port-0-pro-4fju66f2clmvatsvw.sel5.cloudtype.app")!
    }

    var path: String {
        switch self {
        case .login:
            return "/auth/kakao/login/token"
        case .getCount:
            return "/letter/count"
        case .postNewLetter:
            return "/letter"
        case let .fetchDetailLetter(id), let .deleteLetter(id):
            return "/letter/\(id)"
        case .letterMy:
            return "/letter/my"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .postNewLetter:
            return .post
        case .getCount, .fetchDetailLetter, .letterMy:
            return .get
        case .deleteLetter:
            return .delete
        }
    }
    var task: Task {
        switch self {
        case .login(let code):
            return .requestParameters(
                parameters: [
                    "kakaoAccessToken": code
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .getCount(let phone):
            return .requestParameters(
                parameters: [
                    "phone-number": phone
                ],
                encoding: URLEncoding.queryString
            )
        case .postNewLetter(let text, let type, let phone):
            return .requestParameters(
                parameters: [
                    "text": text,
                    "type": type,
                    "targetPhoneNumber": phone
                ],
                encoding: JSONEncoding.default
            )
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .login:
            return Header.tokenIsEmpty.header()
        case .getCount, .postNewLetter, .fetchDetailLetter, .deleteLetter, .letterMy:
            return Header.accessToken.header()
        }
    }
}
