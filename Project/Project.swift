import ProjectDescription

// MARK: - Project

enum ProjectSettings {
	public static var organizationName: String { "leonovka" }
	public static var projectName: String { "MdEditor" }
	public static var appVersionName: String { "1.0.0" }
	public static var appVersionBuild: Int { 1 }
	public static var developmentTeam: String { "" }
	public static var targetVersion: String { "15.0" }
	public static var bundleId: String { "\(organizationName).\(projectName)" }
}

private var swiftLintTargetScript: TargetScript {
	let swiftLintScriptString = """
		export PATH="$PATH:/opt/homebrew/bin"
		if which swiftlint > /dev/null; then
		  swiftlint
		else
		  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
		  exit 1
		fi
		"""

	return TargetScript.pre(
		script: swiftLintScriptString,
		name: "Run SwiftLint",
		basedOnDependencyAnalysis: false
	)
}

private let scripts: [TargetScript] = [
	swiftLintTargetScript
]

let project = Project(
	name: ProjectSettings.projectName,
	organizationName: ProjectSettings.organizationName,
	packages: [
		.local(path: .relativeToManifest("../Packages/TaskManagerPackage")),
		.local(path: .relativeToManifest("../Packages/DataStructuresPackage")),
		.local(path: .relativeToManifest("../Packages/MarkdownPackage"))
	],
	settings: .settings(
		base: [
			"DEVELOPMENT_TEAM": "\(ProjectSettings.developmentTeam)",
			"MARKETING_VERSION": "\(ProjectSettings.appVersionName)",
			"CURRENT_PROJECT_VERSION": "\(ProjectSettings.appVersionBuild)",
			"DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym"
		],
		defaultSettings: .recommended()
	),
	targets: [
		Target(
			name: ProjectSettings.projectName,
			platform: .iOS,
			product: .app,
			bundleId: ProjectSettings.bundleId,
			deploymentTarget: .iOS(targetVersion: ProjectSettings.targetVersion, devices: .iphone),
			infoPlist: "Environments/Info.plist",
			sources: ["Sources/**", "Shared/**"],
			resources: ["Resources/**", .folderReference(path: "Examples")],
			scripts: scripts,
			dependencies: [
				.package(product: "TaskManagerPackage"),
				.package(product: "DataStructuresPackage"),
				.package(product: "MarkdownPackage")
			]
		),
		Target(
			name: "\(ProjectSettings.projectName)Tests",
			platform: .iOS,
			product: .unitTests,
			bundleId: "\(ProjectSettings.bundleId)Tests",
			deploymentTarget: .iOS(targetVersion: ProjectSettings.targetVersion, devices: .iphone),
			infoPlist: .none,
			sources: ["Tests/**"],
			dependencies: [
				.target(name: "\(ProjectSettings.projectName)")
			]
		),
		Target(
			name: "\(ProjectSettings.projectName)UITests",
			platform: .iOS,
			product: .uiTests,
			bundleId: "\(ProjectSettings.bundleId)UITests",
			deploymentTarget: .iOS(targetVersion: ProjectSettings.targetVersion, devices: .iphone),
			infoPlist: .none,
			sources: ["UITests/**", "Shared/**"],
			resources: ["Resources/**"],
			dependencies: [
				.target(name: "\(ProjectSettings.projectName)")
			],
			settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
		)
	]
)
