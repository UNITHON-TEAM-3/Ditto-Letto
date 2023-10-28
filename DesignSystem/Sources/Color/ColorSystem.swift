import UIKit

public extension UIColor {
    enum Colors {
        case colors(Colors)
    }

    static func color(_ style: Colors) -> UIColor {
        switch style {
        case let .colors(colorable as Colorable):
            return colorable.color
        }
    }
}
