import UIKit

extension UITableViewCell {
    func setImageForProgress(_ progress: Int, _ imageView: UIImageView) {
        switch progress {
        case ProgressType.type1.rawValue:
            imageView.image = .Image.state1
        case ProgressType.type2.rawValue:
            imageView.image = .Image.state2
        case ProgressType.type3.rawValue:
            imageView.image = .Image.state3
        case ProgressType.type4.rawValue:
            imageView.image = .Image.state4
        case ProgressType.type5.rawValue:
            imageView.image = .Image.state5
        case ProgressType.type6.rawValue:
            imageView.image = .Image.state6
        case ProgressType.type7.rawValue:
            imageView.image = .Image.state7
        default:
            break
        }
    }

    func setImageForTransportation(_ type: String, _ imageView: UIImageView) {
        switch type {
        case TransportationType.airplane.rawValue:
            imageView.image = .Image.airplaneIcon
        case TransportationType.car.rawValue:
            imageView.image = .Image.carIcon
        case TransportationType.bicycle.rawValue:
            imageView.image = .Image.bikeIcon
        case TransportationType.horse.rawValue:
            imageView.image = .Image.horseIcon
        case TransportationType.running.rawValue:
            imageView.image = .Image.runningIcon
        case TransportationType.walk.rawValue:
            imageView.image = .Image.walkIcon
        default:
            break
        }
    }
}
