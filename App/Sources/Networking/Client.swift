import Foundation
import Moya

enum API {
    case login(_ code: String)
    case letterMy
}

extension API: TargetType {
    var baseURL: URL {
        let url = URL(string: "https://port-0-pro-4fju66f2clmvatsvw.sel5.cloudtype.app") ?? URL(string: "")!
        return url
    }

    var path: String {
        switch self {
        case .login:
            return "/auth/kakao/login/token"
        case .letterMy:
            return "/letter/my"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .letterMy:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .login(let code):
            return .requestParameters(parameters:
                [ "kakaoAccessToken": code ],
                encoding: JSONEncoding.prettyPrinted)
        case .letterMy:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .login:
            return Header.tokenIsEmpty.header()
        case .letterMy:
            guard let token = Token.accessToken else { return ["Contect-Type": "application/json"] }
            return ["Authorization": "Bearer " + token, "Contect-Type": "application/json"]
        }
    }
}
