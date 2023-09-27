import Foundation

struct CountModel: Codable {
    let code: String
    let message: String
    let data: CountData
}

struct CountData: Codable {
    let toCount: Int
    let fromCount: Int
}
