//
//  MainCoordinator.swift
//  TodoList
//

import UIKit
import TaskManagerPackage
import MarkdownPackage

final class MainCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController

	// MARK: - Initialization

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods

	override func start() {
		showMainMenuScene()
	}
}

// MARK: - Private methods

private extension MainCoordinator {

	func showMessage(message: String) {
		let alert = UIAlertController(title: L10n.Message.text, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: L10n.Ok.text, style: .default)
		alert.addAction(action)
		
		navigationController.present(alert, animated: true, completion: nil)
	}

	func showMainMenuScene() {
		let assembler = MenuAssembler()
		let recentFileManager = StubRecentFileManager()
		let viewController = assembler.assembly(recentFileManager: recentFileManager, delegate: self)
		navigationController.setViewControllers([viewController], animated: true)
	}

	private func showTodoListScene(text: String) {
		let taskManager: ITaskManager = TaskManager()

		let document = MarkdownToDocument().convert(markdownText: text)
		let taskRepository: ITaskRepository = TaskScanner(document: document)

		taskManager.addTasks(tasks: taskRepository.getTasks())

		let assembler = TodoListAssembler(taskManager: OrderedTaskManager(taskManager: taskManager))
		let viewController = assembler.assembly(createTaskClosure: nil)

		navigationController.present(viewController, animated: true)
	}

	func showTextEditorScene(file: File) {
		let viewController = TextEditorAssembler().assembly(file: file, delegate: self)

		navigationController.pushViewController(viewController, animated: true)
	}

	func showPdfPreviewScene(file: File) {
		let viewController = PdfPreviewAssembler().assembly(file: file)

		navigationController.pushViewController(viewController, animated: true)
	}

	func runFileManagerFlow() {
		let topViewController = navigationController.topViewController
		let coordinator = FileManagerCoordinator(
			navigationController: navigationController,
			topViewController: topViewController
		)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			guard let self = self, let coordinator = coordinator else { return }
			self.removeDependency(coordinator)
			if let topViewController = topViewController {
				self.navigationController.popToViewController(topViewController, animated: true)
			} else {
				self.navigationController.viewControllers.removeAll()
			}
		}

		coordinator.start()
	}
}

// MARK: - IMainMenuDelegate

extension MainCoordinator: IMainMenuDelegate {

	func showAbout() {
		switch File.parse(url: Endpoints.documentAbout) {
		case .success(let aboutFile):
			showPdfPreviewScene(file: aboutFile)
		case .failure:
			break
		}
	}

	func openFileExplorer() {
		runFileManagerFlow()
	}

	func newFile() {
		showMessage(message: L10n.Menu.newFile)
	}

	func openFile(file: File) {
		showTextEditorScene(file: file)
	}
}

extension MainCoordinator: ITextEditorDelegate {
	func openTodoList(text: String) {
		showTodoListScene(text: text)
	}
}
