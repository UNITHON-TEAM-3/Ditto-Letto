import ProjectDescriptionHelpers
import ProjectDescription

let project = Project.staticLibrary(
    name: "DesignSystem",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone, .ipad])
)
