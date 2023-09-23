import Foundation
import Moya

enum API {
    case login(_ code: String)
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
        }
    }
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .login(let code):
            return .requestParameters(parameters:
                [ "kakaoAccessToken": code ],
                encoding: JSONEncoding.prettyPrinted)
        }
    }

    var headers: [String: String]? {
        switch self {
        case .login:
            return Header.tokenIsEmpty.header()
        }
    }
}
