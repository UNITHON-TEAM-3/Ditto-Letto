import ProjectDescriptionHelpers
import ProjectDescription

let project = Project.excutable(
    name: "Ditto-Letto",
    platform: .iOS,
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    dependencies: [
        .project(target: "DesignSystem", path: "../DesignSystem")
    ]
)
