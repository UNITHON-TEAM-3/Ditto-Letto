import Foundation

struct LetterMyModel: Codable {
    let code: String
    let message: String
    let data: LetterMyData
}

struct LetterMyData: Codable {
    let inBoxLetters: [BoxLetterData]
    let outBoxLetters: [BoxLetterData]
}

struct BoxLetterData: Codable {
    let phoneNumber: String
    let mediumType: String
    let type: String
    let progressLevel: Int
    let previewText: String
    let direction: String
    let arrived: Bool
}
