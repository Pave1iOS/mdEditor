//
//  FileManagerModel.swift
//  MdEditor
//
//  Created by Kirill Leonov on 14.02.2024.
//  Copyright © 2024 leonovka.SwiftBook. All rights reserved.
//

import Foundation

enum FileManagerModel {

	enum Request {
		case fileSelected(indexPath: IndexPath)
	}

	struct Response {
		let currentFile: File?
		let files: [File]
	}

	struct ViewModel {
		let currentFolderName: String
		let files: [FileModel]

		struct FileModel {
			let name: String
			let info: String
			let isFolder: Bool
		}
	}
}
