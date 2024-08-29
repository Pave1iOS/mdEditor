//
//  Accessible.swift
//  TodoList
//
//  Created by Kirill Leonov on 17.01.2024.
//  Copyright © 2024 MyTeam. All rights reserved.
//

import UIKit

protocol Accessible {
	func generateAccessibilityIdentifiers()
}

extension Accessible {

	func generateAccessibilityIdentifiers() {
#if DEBUG
		let mirror = Mirror(reflecting: self)

		for child in mirror.children {
			if let view = child.value as? UIView {
				let identifier = child.label?.split(separator: "_").last ?? ""
				view.accessibilityIdentifier = "\(type(of: self)).\(identifier)"
			}
		}
#endif
	}
}
