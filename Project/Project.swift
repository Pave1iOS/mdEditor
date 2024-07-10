import ProjectDescription

// enum для настроек проекта
enum ProjectSettings {
	public static var organizationName: String { "team.seefood" }
	public static var projectName: String { "MdEditor" }
	public static var appVersionName: String { "1.0.0" }
	public static var appVersionBuild: Int { 1 }
	public static var developmentTeam: String { "" }
	public static var targetVersion: String { "15.0" }
	public static var bundleId: String { "\(organizationName).\(projectName)" }
	public static var uiTestsName: String { "TodoListUITests" }
}

// внутри доп настройки info.plist для отказа от сториборда
let infoPlist: [String: Plist.Value] = [
	"UIApplicationSceneManifest": [
		"UIApplicationSupportsMultipleScenes": false,
		"UISceneConfigurations": [
			"UIWindowSceneSessionRoleApplication": [
				[
					"UISceneConfigurationName": "Default Configuration",
					"UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
				]
			]
		]
	],
	"UILaunchScreen": [:]
]

// внутри текст скрипта из первого урока
// + создание скрипта с необходимыми настройками: имя, позиция, выключение опции
var swiftLintTargetScript: TargetScript {
	let swiftLintScriptString = """
   export PATH="$PATH:/opt/homebrew/bin"
   if which swiftlint > /dev/null; then
   swiftlint
   else
   echo "warning: Swiftlint not installed, download from https://github.com/realm/SwiftLint"
   fi
 """

	return TargetScript.pre(
		script: swiftLintScriptString,
		name: "Run SwiftLint",
		basedOnDependencyAnalysis: false
	)
}

let project = Project(
	name: ProjectSettings.projectName,
	organizationName: ProjectSettings.organizationName,
	options: .options(
		defaultKnownRegions: ["Base", "ru"],
		developmentRegion: "Base"
	),
	packages: [
		.local(path: .relativeToManifest("../Packages/TaskManagerPackage")),
		.local(path: .relativeToManifest("../Packages/DataStructuresPackage"))
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
			destinations: [.iPhone],
			product: .app,
			bundleId: ProjectSettings.bundleId,
			deploymentTargets: .iOS(ProjectSettings.targetVersion),
			infoPlist: .extendingDefault(with: infoPlist),
			sources: [
				"TodoList/Sources/**",
				"TodoList/Shared/**"
			],
			resources: [
				"TodoList/Resources/**"
			],
			scripts: [
				swiftLintTargetScript
			],
			dependencies: [
				.package(product: "TaskManagerPackage"),
				.package(product: "DataStructuresPackage")
			]
		),
		Target(
			name: ProjectSettings.uiTestsName,
			destinations: [.iPhone],
			product: .uiTests,
			bundleId: "\(ProjectSettings.bundleId).\(ProjectSettings.uiTestsName)",
			deploymentTargets: .iOS(ProjectSettings.targetVersion),
			sources: [
				"TodoListUITests/Sources/**",
				"TodoList/Shared/**"
			],
			resources: "TodoList/Resources/**",
			dependencies: [
				.target(name: ProjectSettings.projectName)
			]
		)
	],
	schemes: [
		Scheme(
			name: ProjectSettings.projectName,
			shared: true,
			buildAction: .buildAction(targets: ["MdEditor"]),
			testAction: .targets(["TodoListUITests"]),
			runAction: .runAction(executable: "MdEditor")
		),
		Scheme(
			name: ProjectSettings.uiTestsName,
			shared: true,
			buildAction: .buildAction(targets: ["TodoListUITests"]),
			testAction: .targets(["TodoListUITests"]),
			runAction: .runAction(executable: "TodoListUITests")
		)
	]
)
