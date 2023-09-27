// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum DittoLettoAsset {
  public enum Color {
    public static let bg = DittoLettoColors(name: "bg")
    public static let dark = DittoLettoColors(name: "dark")
    public static let gray1 = DittoLettoColors(name: "gray1")
    public static let gray2 = DittoLettoColors(name: "gray2")
    public static let main = DittoLettoColors(name: "main")
    public static let third = DittoLettoColors(name: "third")
  }
  public enum Image {
    public static let generalImage = DittoLettoImages(name: "GeneralImage")
    public static let privateImage = DittoLettoImages(name: "PrivateImage")
    public static let profileImage = DittoLettoImages(name: "ProfileImage")
    public static let airplane = DittoLettoImages(name: "airplane")
    public static let airplaneIcon = DittoLettoImages(name: "airplaneIcon")
    public static let bike = DittoLettoImages(name: "bike")
    public static let bikeIcon = DittoLettoImages(name: "bikeIcon")
    public static let car = DittoLettoImages(name: "car")
    public static let carIcon = DittoLettoImages(name: "carIcon")
    public static let emptyFolder = DittoLettoImages(name: "emptyFolder")
    public static let horse = DittoLettoImages(name: "horse")
    public static let horseIcon = DittoLettoImages(name: "horseIcon")
    public static let kakaoButton = DittoLettoImages(name: "kakaoButton")
    public static let loginImage = DittoLettoImages(name: "loginImage")
    public static let lunchImage = DittoLettoImages(name: "lunchImage ")
    public static let message = DittoLettoImages(name: "message")
    public static let receive = DittoLettoImages(name: "receive")
    public static let redFolder = DittoLettoImages(name: "redFolder")
    public static let running = DittoLettoImages(name: "running")
    public static let runningIcon = DittoLettoImages(name: "runningIcon")
    public static let send = DittoLettoImages(name: "send")
    public static let state01 = DittoLettoImages(name: "state01")
    public static let state02 = DittoLettoImages(name: "state02")
    public static let state03 = DittoLettoImages(name: "state03")
    public static let state04 = DittoLettoImages(name: "state04")
    public static let state05 = DittoLettoImages(name: "state05")
    public static let state06 = DittoLettoImages(name: "state06")
    public static let state07 = DittoLettoImages(name: "state07")
    public static let twoLine = DittoLettoImages(name: "twoLine")
    public static let walk = DittoLettoImages(name: "walk")
    public static let walkIcon = DittoLettoImages(name: "walkIcon")
    public static let windly = DittoLettoImages(name: "windly")
    public static let yellowFolder = DittoLettoImages(name: "yellowFolder")
    public static let yellowHeart = DittoLettoImages(name: "yellowHeart")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class DittoLettoColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension DittoLettoColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: DittoLettoColors) {
    let bundle = DittoLettoResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct DittoLettoImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = DittoLettoResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension DittoLettoImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the DittoLettoImages.image property")
  convenience init?(asset: DittoLettoImages) {
    #if os(iOS) || os(tvOS)
    let bundle = DittoLettoResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:enable all
// swiftformat:enable all
