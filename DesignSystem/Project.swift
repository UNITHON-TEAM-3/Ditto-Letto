import ProjectDescriptionHelpers
import ProjectDescription

let project = Project.dynamicLibrary(
    name: "DesignSystem",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone])
)
