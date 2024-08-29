//
//  MenuModel.swift
//  MdEditor
//
//  Created by Kirill Leonov on 15.02.2024.
//  Copyright © 2024 leonovka.SwiftBook. All rights reserved.
//

import Foundation

enum MenuModel {

	enum MenuIdentifier {
		case openFile
		case newFile
		case showAbout
	}

	enum Request {
		case menuItemSelected(indexPath: IndexPath)
		case recentFileSelected(indexPath: IndexPath)
	}

	struct Response {
		let recentFiles: [RecentFile]
		let menu: [MenuIdentifier]
	}

	struct ViewModel {
		let recentFiles: [RecentFile]
		let menu: [MenuItem]

		struct MenuItem {
			let title: String
			let item: MenuIdentifier
		}

		struct RecentFile {
			let previewText: String
			let fileName: String
		}
	}
}
