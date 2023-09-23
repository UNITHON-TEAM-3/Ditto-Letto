import Foundation

struct LetterMyModel: Codable {
    let code: String
    let message: String
    let dataList: [LetterMyData]
}

struct LetterMyData: Codable {
    let phoneNumber: String
    let mediumType: String
    let type: String
    let progressLevel: Int
    let previewText: String
    let direction: String
    let arrivedAt: Bool
}
