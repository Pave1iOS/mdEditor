//
//  RecentFileManager.swift
//  MdEditor
//
//  Created by Kirill Leonov on 15.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation

protocol IRecentFileManager {
	func getRecentFiles() -> [RecentFile]
}

final class RecentFileManager: IRecentFileManager {
	func getRecentFiles() -> [RecentFile] {
		return []
	}
}

final class StubRecentFileManager: IRecentFileManager {
	func getRecentFiles() -> [RecentFile] {
		return [
			RecentFile(
				previewText: "# Markdown Test",
				url: Endpoints.documentTest,
				createDate: Date()
			),

			RecentFile(
				previewText: "# Как работать в Markdown с Заголовками",
				url: Endpoints.documentHeadings,
				createDate: Date()
			),

			RecentFile(
				previewText: "# Вставка кода (code)",
				url: Endpoints.documentCode,
				createDate: Date()
			),

			RecentFile(
				previewText: "# Экранирование (escaping characters)",
				url: Endpoints.documentEscapingChars,
				createDate: Date()
			)
		]
	}
}
