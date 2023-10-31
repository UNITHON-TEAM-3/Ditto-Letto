import ProjectDescription

extension Project{
    public static func excutable(
        name: String,
        platform: Platform,
        product: Product = .app,
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "15.0", devices: [.iphone]),
        dependencies: [TargetDependency]
    ) -> Project {
        return Project(
            name: name,
            organizationName: unithonOrganizationName,
            targets: [
                
                Target(
                    name: name,
                    platform: platform,
                    product: product,
                    bundleId: "\(unithonOrganizationName).\(name)",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .file(path: Path("Support/Info.plist")),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    scripts: [.swiftlint],
                    dependencies: [
                        .project(target: "ThirdPartyLib", path: "../ThirdPartyLib"),
                        .project(target: "DesignSystem", path: "../DesignSystem")
                    ] + dependencies
                )
            ]
        )
    }
}
