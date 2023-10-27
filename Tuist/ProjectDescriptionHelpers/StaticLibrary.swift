import ProjectDescription

extension Project {
    public static func staticLibrary(
        name: String,
        platform: Platform = .iOS,
        infoPlist: InfoPlist = .default,
        deploymentTarget: DeploymentTarget,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: name,
            targets: [
                Target(
                    name: name,
                    platform: platform,
                    product: .staticLibrary,
                    bundleId: "\(unithonOrganizationName).\(name)",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .file(path: Path("Support/Info.plist")),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    scripts: [.swiftlint],
                    dependencies: dependencies
                )
            ]
        )
    }
}
