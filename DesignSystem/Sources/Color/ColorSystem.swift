import UIKit

public extension UIColor {
    enum Colors {
        case dittoLettoColor(Colors)
    }

    static func color(_ style: Colors) -> UIColor {
        switch style {
        case let .dittoLettoColor(colorable as Colorable):
            return colorable.color
        }
    }
}
