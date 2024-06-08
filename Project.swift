import ProjectDescription

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
		 exit 1
		 fi
	"""
	
	return TargetScript.pre(
		script: swiftLintScriptString,
		name: "Run SwiftLint",
		basedOnDependencyAnalysis: false
	)
}

let target = Target(
	name: "mdEditor",
	destinations: [.iPhone],
	product: .app,
	bundleId: "ru.paveldev.mdEditor",
	infoPlist: .extendingDefault(with: infoPlist),
	sources: ["Sources/**"]
)

// это дополнительные параметры втаргете,
// помимо обязательных: name, destinations, product и bundleId
//
// infoPlist: extendingDefault(with: infoPlist),
// sources: ["Sources/**"],
// scripts: [swiftLintTargetScript]

let project = Project(
	name: "mdEditor",
	targets: [
		target
	]
)
