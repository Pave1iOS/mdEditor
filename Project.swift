import ProjectDescription

public var scripts: [TargetScript] {
	
	var scripts = [TargetScript]()
	
	let swiftLintScriptString = "SwiftLint/swiftlint --fix && SwiftLint/swiftlint"
	let swiftLintScript = TargetScript.post(script: swiftLintScriptString, name: "SwiftLint")
	
	scripts.append(swiftLintScript)
	return scripts
}

let project = Project(
	name: "NewApp",
	organizationName: "abudidabudai",
	targets: [
		Target (
			name: "NewApp",
			platform: .iOS,
			product: .app,
			bundleId: "NewApp" ,
			infoPlist: "Resources/Info.plist",
			sources: ["Sources/**"],
			resources: ["Resources/**"],
			scripts: scripts,
			dependencies: [
				/* Target dependencies can be defined here */
				/* framework(path: "framework") */
			]
		),
		
		Target (
			name: "NewAppTests",
			platform: .iOS,
			product: .unitTests,
			bundleId: "NewAppTests",
			infoPlist: "Resources/Info.plist",
			sources: ["Tests/**"],
			dependencies: [
				.target(name: "NewApp")
			]
		)
	]
)
