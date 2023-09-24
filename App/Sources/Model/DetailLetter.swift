import Foundation

struct DetailLetterModel: Codable {
    let code: String
    let message: String
    let data: LetterData
}

struct LetterData: Codable {
    let id: Int
    let text: String
    let sentAt: String
    let from: String
    let mediumType: String
    let type: String
    let toCount: Int
    let fromCount: Int
}
