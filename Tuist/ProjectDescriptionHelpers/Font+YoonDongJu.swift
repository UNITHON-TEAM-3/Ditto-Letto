import UIKit

public extension UIFont {
    // swiftlint:disable identifier_name
    enum YoonDongJuFontSystem: Fontable {
        case headline
        case body
        case caption
    }
    // swiftlint:enable identifier_name

    static func yoondongju(_ style: YoonDongJuFontSystem) -> UIFont {
        return style.font
    }
}

public extension UIFont.YoonDongJuFontSystem {
    var font: UIFont {
        switch self {
        case .headline: return UIFont(font: DesignSystemFontFamily.YoonDongJu2.regular, size: 18) ?? .init()
        case .body: return UIFont(font: DesignSystemFontFamily.YoonDongJu2.regular, size: 17) ?? .init()
        case .caption: return UIFont(font: DesignSystemFontFamily.YoonDongJu2.regular, size: 12) ?? .init()
        }
    }
}
