import Foundation

struct TokenModel: Codable {
    let code: String
    let message: String
    let data: TokenData
}

struct TokenData: Codable {
    let accessToken: String
}
