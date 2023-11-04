import ProjectDescription

extension Project {
    public static func designSystem(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        infoPlist: InfoPlist = .default,
        deploymentTarget: DeploymentTarget,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: name,
            packages: packages,
            targets: [
                Target(
                    name: name,
                    platform: platform,
                    product: .framework,
                    bundleId: "\(unithonOrganizationName).\(name)",
                    deploymentTarget: deploymentTarget,
                    infoPlist: infoPlist,
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    scripts: [.swiftlint],
                    dependencies: dependencies
                )
            ]
        )
    }
}
