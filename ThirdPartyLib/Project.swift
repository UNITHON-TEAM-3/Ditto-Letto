import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "ThirdPartyLib",
    packages: [
        .RxSwift,
        .Moya,
        .Then,
        .SnapKit,
        .Kingfisher,
        .Lottie,
        .KakaoSDK
    ],
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone, .ipad]),
    dependencies: [
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.RxMoya,
        .SPM.Then,
        .SPM.SnapKit,
        .SPM.Kingfisher,
        .SPM.Lottie,
        .SPM.KakaoSDK
    ]
)
