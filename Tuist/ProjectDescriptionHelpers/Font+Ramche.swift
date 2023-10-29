import UIKit

public extension UIFont {
    // swiftlint:disable identifier_name
    enum RamcheFontSystem: Fontable {
        case title1
        case title2
        case title3
        case headline
        case body
        case subheadline
        case footnote
        case caption1
        case caption2
    }
    // swiftlint:enable identifier_name

    static func ramche(_ style: RamcheFontSystem) -> UIFont {
        return style.font
    }
}

public extension UIFont.RamcheFontSystem {
    var font: UIFont {
        switch self {
        case .title1: return UIFont(font: DesignSystemFontFamily.Ramche.regular, size: 28) ?? .init()
        case .title2: return UIFont(font: DesignSystemFontFamily.Ramche.regular, size: 22) ?? .init()
        case .title3: return UIFont(font: DesignSystemFontFamily.Ramche.regular, size: 20) ?? .init()
        case .headline: return UIFont(font: DesignSystemFontFamily.Ramche.regular, size: 18) ?? .init()
        case .body: return UIFont(font: DesignSystemFontFamily.Ramche.regular, size: 17) ?? .init()
        case .subheadline: return UIFont(font: DesignSystemFontFamily.Ramche.regular, size: 15) ?? .init()
        case .footnote: return UIFont(font: DesignSystemFontFamily.Ramche.regular, size: 13) ?? .init()
        case .caption1: return UIFont(font: DesignSystemFontFamily.Ramche.regular, size: 12) ?? .init()
        case .caption2: return UIFont(font: DesignSystemFontFamily.Ramche.regular, size: 11) ?? .init()
        }
    }
}
