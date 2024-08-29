//
//  AccessibilityIdentifier.swift
//  TodoList
//
//  Created by Kirill Leonov on 03.04.2023.
//

enum AccessibilityIdentifier {

	enum LoginScene: CustomStringConvertible {
		case textFieldLogin
		case textFieldPass
		case buttonLogin

		var description: String {
			switch self {
			case .textFieldLogin:
				return "loginScene.textFieldLogin"
			case .textFieldPass:
				return "loginScene.textFieldPass"
			case .buttonLogin:
				return "loginScene.buttonLogin"
			}
		}
	}

	enum MenuScene: CustomStringConvertible {
		case recentFiles
		case recentFilesCell(index: Int)
		case menu
		case menuCell(index: Int)

		var description: String {
			switch self {
			case .recentFiles:
				return "MenuScene.recentFiles"
			case .recentFilesCell(let index):
				return "MenuScene.recentFiles-\(index)"
			case .menu:
				return "MenuScene.menu"
			case .menuCell(let index):
				return "MenuScene.menuCell-\(index)"
			}
		}
	}

	enum TodoListScene: CustomStringConvertible {
		case table
		case cell(section: Int, row: Int)
		case section(Int)

		var description: String {
			switch self {
			case .table:
				return "todoListScene.table"
			case .cell(let section, let row):
				return "todoListScene.cell-\(section)-\(row)"
			case .section(let section):
				return "todoListScene.section-\(section)"
			}
		}
	}

	enum TextEditorScene: CustomStringConvertible {
		case textViewEditor
		case textViewPreview
		case saveButton
		case shareButton
		case printButton
		case tasksButton

		var description: String {
			switch self {
			case .textViewEditor:
				return "TextEditorScene.textViewEditor"
			case .textViewPreview:
				return "TextEditorScene.textViewPreview"
			case .saveButton:
				return "TextEditorScene.saveButton"
			case .shareButton:
				return "TextEditorScene.shareButton"
			case .printButton:
				return "TextEditorScene.printButton"
			case .tasksButton:
				return "TextEditorScene.tasksButton"
			}
		}
	}

	enum PdfPreviewScene: CustomStringConvertible {
		case textView

		var description: String {
			"PdfPreviewScene.textView"
		}
	}
}
