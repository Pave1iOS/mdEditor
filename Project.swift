import ProjectDescription

public var scripts: [TargetScript] {
	
	var scripts = [TargetScript]()
	
	let swiftLintScriptString = "SwiftLint/swiftlint --fix && SwiftLint/swiftlint"
	let swiftLintScript = TargetScript.post(script: swiftLintScriptString, name: "SwiftLint")
	
	scripts.append(swiftLintScript)
	return scripts
}

let project = Project(
	name: "mdEditor",
	organizationName: "SeeFood",
	targets: [
		Target (
			name: "mdEditor",
			platform: .iOS,
			product: .app,
			bundleId: "mdEditor" ,
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
			name: "mdEditorTests",
			platform: .iOS,
			product: .unitTests,
			bundleId: "mdEditorTests",
			infoPlist: "Resources/Info.plist",
			sources: ["Tests/**"],
			dependencies: [
				.target(name: "mdEditor")
			]
		)
	]
)
