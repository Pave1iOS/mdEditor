import UIKit
enum AccessibilityIdentifier {
	// UI LoginViewController
	static let textFieldLogin = "LoginViewController.textFieldLogin"
	static let textFieldPass = "LoginViewController.textFieldPass"
	static let buttonLogin = "LoginViewController.buttonLogin"

	enum MenuScene {
		case recentFiles
		case menu

		var description: String {
			switch self {
			case .recentFiles:
				"MenuViewController.collectionViewRecentFiles"
			case .menu:
				"MenuViewController.tableViewMenu"
			}
		}
	}

	enum TextPreviewScene {
		case textView

		var description: String {
			switch self {
			case .textView:
				"TextPreviewViewController.textView"
			}
		}
	}

	enum ToDoListScene {
		case tableView
		case cell(row: Int, section: Int)
		case section(_ section: Int)

		var description: String {
			switch self {
			case .tableView:
				"TodoListViewController.tableView"
			case .cell(let row, let section):
				"TodoListViewController.cell.\(row).\(section)"
			case .section(let section):
				"TodoListViewController.section.\(section)"
			}
		}
	}
}
