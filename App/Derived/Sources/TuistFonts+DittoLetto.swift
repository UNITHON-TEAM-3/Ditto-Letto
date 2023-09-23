// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(OSX)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum DittoLettoFontFamily {
  public enum Ramche {
    public static let regular = DittoLettoFontConvertible(name: "Ramche", family: "Ramche", path: "Ramche.otf")
    public static let all: [DittoLettoFontConvertible] = [regular]
  }
  public enum YoonDongJu1 {
    public static let regular = DittoLettoFontConvertible(name: "YOON-DONG-JU1", family: "YOON-DONG-JU1", path: "GS.otf")
    public static let all: [DittoLettoFontConvertible] = [regular]
  }
  public enum YunBongGil {
    public static let regular = DittoLettoFontConvertible(name: "YUN-BONG-GIL", family: "YUN-BONG-GIL", path: "독립서체_윤봉길_GS.otf")
    public static let all: [DittoLettoFontConvertible] = [regular]
  }
  public static let allCustomFonts: [DittoLettoFontConvertible] = [Ramche.all, YoonDongJu1.all, YunBongGil.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct DittoLettoFontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(OSX)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return Bundle.module.url(forResource: path, withExtension: nil)
  }
}

public extension DittoLettoFontConvertible.Font {
  convenience init?(font: DittoLettoFontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}
// swiftlint:enable all
// swiftformat:enable all
