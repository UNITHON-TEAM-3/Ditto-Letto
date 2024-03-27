import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "ThirdPartyLib",
    packages: [
        .RxSwift,
        .RxGesture,
        .Moya,
        .Then,
        .SnapKit,
        .Kingfisher,
        .KakaoSDK
    ],
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    dependencies: [
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.RxGesture,
        .SPM.RxMoya,
        .SPM.Then,
        .SPM.SnapKit,
        .SPM.Kingfisher,
        .SPM.KakaoSDK
    ]
)
