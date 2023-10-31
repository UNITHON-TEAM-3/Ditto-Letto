import UIKit

public extension UIFont {
    enum YoonDongJuFontSystem: Fontable {
        case headline
        case body
        case caption
    }

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
