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
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum DesignSystemAsset {
  public enum Color {
  public static let bg = DesignSystemColors(name: "bg")
    public static let dark = DesignSystemColors(name: "dark")
    public static let gray1 = DesignSystemColors(name: "gray1")
    public static let gray2 = DesignSystemColors(name: "gray2")
    public static let main = DesignSystemColors(name: "main")
    public static let third = DesignSystemColors(name: "third")
    public static let white = DesignSystemColors(name: "white")
  }
  public enum Image {
  public static let generalImage = DesignSystemImages(name: "GeneralImage")
    public static let privateImage = DesignSystemImages(name: "PrivateImage")
    public static let profileImage = DesignSystemImages(name: "ProfileImage")
    public static let airplane = DesignSystemImages(name: "airplane")
    public static let airplaneIcon = DesignSystemImages(name: "airplaneIcon")
    public static let backChevron = DesignSystemImages(name: "backChevron")
    public static let bike = DesignSystemImages(name: "bike")
    public static let bikeIcon = DesignSystemImages(name: "bikeIcon")
    public static let car = DesignSystemImages(name: "car")
    public static let carIcon = DesignSystemImages(name: "carIcon")
    public static let diaryOff = DesignSystemImages(name: "diary_off")
    public static let diaryOn = DesignSystemImages(name: "diary_on")
    public static let emptyFolder = DesignSystemImages(name: "emptyFolder")
    public static let homeOff = DesignSystemImages(name: "home_off")
    public static let homeOn = DesignSystemImages(name: "home_on")
    public static let horse = DesignSystemImages(name: "horse")
    public static let horseIcon = DesignSystemImages(name: "horseIcon")
    public static let kakaoButton = DesignSystemImages(name: "kakaoButton")
    public static let launchImage = DesignSystemImages(name: "launchImage")
    public static let loginImage = DesignSystemImages(name: "loginImage")
    public static let message = DesignSystemImages(name: "message")
    public static let pen = DesignSystemImages(name: "pen")
    public static let personOff = DesignSystemImages(name: "person_off")
    public static let personOn = DesignSystemImages(name: "person_on")
    public static let receive = DesignSystemImages(name: "receive")
    public static let redFolder = DesignSystemImages(name: "redFolder")
    public static let replyButton = DesignSystemImages(name: "replyButton")
    public static let running = DesignSystemImages(name: "running")
    public static let runningIcon = DesignSystemImages(name: "runningIcon")
    public static let send = DesignSystemImages(name: "send")
    public static let state01 = DesignSystemImages(name: "state01")
    public static let state02 = DesignSystemImages(name: "state02")
    public static let state03 = DesignSystemImages(name: "state03")
    public static let state04 = DesignSystemImages(name: "state04")
    public static let state05 = DesignSystemImages(name: "state05")
    public static let state06 = DesignSystemImages(name: "state06")
    public static let state07 = DesignSystemImages(name: "state07")
    public static let threeDot = DesignSystemImages(name: "threeDot")
    public static let trashCan = DesignSystemImages(name: "trashCan")
    public static let twoLine = DesignSystemImages(name: "twoLine")
    public static let walk = DesignSystemImages(name: "walk")
    public static let walkIcon = DesignSystemImages(name: "walkIcon")
    public static let windly = DesignSystemImages(name: "windly")
    public static let yellowFolder = DesignSystemImages(name: "yellowFolder")
    public static let yellowHeart = DesignSystemImages(name: "yellowHeart")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class DesignSystemColors {
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

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension DesignSystemColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: DesignSystemColors) {
    let bundle = DesignSystemResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: DesignSystemColors) {
    let bundle = DesignSystemResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct DesignSystemImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = DesignSystemResources.bundle
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

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension DesignSystemImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the DesignSystemImages.image property")
  convenience init?(asset: DesignSystemImages) {
    #if os(iOS) || os(tvOS)
    let bundle = DesignSystemResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: DesignSystemImages) {
    let bundle = DesignSystemResources.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: DesignSystemImages, label: Text) {
    let bundle = DesignSystemResources.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: DesignSystemImages) {
    let bundle = DesignSystemResources.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
