//
//  MenuModel.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 05.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import Foundation

enum MenuModel {
	enum MenuIdentifier {
		case openFile
		case newFile
		case showAbout
	}

	enum Request {
		case menuItemSelected(_ indexPath: IndexPath)
		case recentFileSelected(_ indexPath: IndexPath)
	}

	struct Response {
		let recentFiles: [RecentFile]
		let menu: [MenuIdentifier]
	}

	struct ViewModel {
		let recentFiles: [RecentFile]
		let menu: [MenuItem]

		struct MenuItem { // swiftlint:disable:this nesting
			let title: String
			let item: MenuIdentifier
		}

		struct RecentFile { // swiftlint:disable:this nesting
			let previewText: String
			let fileName: String
		}
	}
}
