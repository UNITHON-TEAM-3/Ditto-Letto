import UIKit

public extension UIColor.Colors {
    enum Colors: Colorable {
        case dark
        case bg
        case main
        case third
        case gray1
        case gray2
        case white
    }
}

public extension UIColor.Colors.Colors {
    var color: UIColor {
        switch self {
        case .dark: return DesignSystemAsset.Color.dark.color
        case .bg: return DesignSystemAsset.Color.bg.color
        case .main: return DesignSystemAsset.Color.main.color
        case .third: return DesignSystemAsset.Color.third.color
        case .gray1: return DesignSystemAsset.Color.gray1.color
        case .gray2: return DesignSystemAsset.Color.gray2.color
        case .white: return DesignSystemAsset.Color.white.color
        }
    }
}
