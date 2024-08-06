//
//  RecentFileManager.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 05.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
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
		let stub: [RecentFile] = [
			RecentFile(
				previewText: "# О приложении",
				url: Bundle.main.url(
					forResource: "Documents/file1",
					withExtension: "md"
				)!,
				createDate: Date()
			),
			
			RecentFile(
				previewText: "# Как работать в Markdown с Заголовками",
				url: Bundle.main.url(
					forResource: "Documents/Folder/file3",
					withExtension: "md"
				)!,
				createDate: Date()
			),
			
			RecentFile(
				previewText: "# Вставка кода (code)",
				url: Bundle.main.url(
					forResource: "Documents/Folder/file4",
					withExtension: "md"
				)!,
				createDate: Date()
			),
			
			RecentFile(
				previewText: "# Экранирования (escaping characters)",
				url: Bundle.main.url(
					forResource: "Documents/file2",
					withExtension: "md"
				)!,
				createDate: Date()
			)
		]
		
		return stub
	}
}
