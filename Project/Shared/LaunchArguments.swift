//
//  LaunchArguments.swift
//  TodoList
//
//  Created by Kirill Leonov on 16.01.2024.
//  Copyright © 2024 MyTeam. All rights reserved.
//

import Foundation

enum LaunchArguments: String {
	case enableTesting = "-enableTesting"
	case runTodoListFlow = "-runTodoListFlow"
	case runMainFlow = "-runMainFlow"

	static func parameters() -> [LaunchArguments: Bool] {
		var parameters = [LaunchArguments: Bool]()

		for argument in CommandLine.arguments {
			if let parameter = LaunchArguments(rawValue: argument) {
				parameters[parameter] = true
			}
		}

		return parameters
	}
}

