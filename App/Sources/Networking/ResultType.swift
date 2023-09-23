import Foundation

enum NetworkingResult: Int {
    case getOk = 200
    case wrongRq = 400
    case payloadTooLarge = 413
    case unsupportedMediaType = 415
    case fault = 0
}
