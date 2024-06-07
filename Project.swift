import ProjectDescription

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
	"UILaunchStoryboardName": "LaunchScreen"
]

let project = Project(
	name: "mdEditor",
	organizationName: "SeeFood",
	targets: [
		Target (
			name: "mdEditor",
			platform: .iOS,
			product: .app,
			bundleId: "com.ios.mdEditor" ,
			infoPlist: .extendingDefault(with: infoPlist),
			sources: ["Sources/**"],
			resources: ["Resources/**"],
			dependencies: [
				/* Target dependencies can be defined here */
				/* framework(path: "framework") */
			]
		),
	]
)
