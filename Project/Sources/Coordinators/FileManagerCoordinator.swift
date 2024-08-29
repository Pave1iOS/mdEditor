//
//  FileManagerCoordinator.swift
//  MdEditor
//
//  Created by Kirill Leonov on 15.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import UIKit
import TaskManagerPackage
import MarkdownPackage

protocol IFileManagerCoordinator: ICoordinator {
	/// Метод для завершении сценария
	var finishFlow: (() -> Void)? { get set }
}

final class FileManagerCoordinator: NSObject, IFileManagerCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private var topViewController: UIViewController?

	// MARK: - Internal properties

	var finishFlow: (() -> Void)?

	// MARK: - Initialization

	init(navigationController: UINavigationController, topViewController: UIViewController?) {
		self.navigationController = navigationController
		self.topViewController = topViewController

		super.init()

		navigationController.delegate = self
	}

	// MARK: - Internal methods

	func start() {
		showFileManagerScene(file: nil)
	}
}

// MARK: - Private methods

private extension FileManagerCoordinator {

	func showFileManagerScene(file: File?) {
		let viewController = FileManagerAssembler().assembly(
			fileExplorer: FileExplorer(),
			delegate: self,
			file: file
		)
		navigationController.pushViewController(viewController, animated: true)
	}

	func showTextEditorScene(file: File) {
		let viewController = TextEditorAssembler().assembly(file: file, delegate: self)
		navigationController.pushViewController(viewController, animated: true)
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
}

// MARK: - UINavigationControllerDelegate

extension FileManagerCoordinator: UINavigationControllerDelegate {

	func navigationController(
		_ navigationController: UINavigationController,
		didShow viewController: UIViewController,
		animated: Bool
	) {
		if viewController === topViewController {
			finishFlow?()
		}
	}
}

// MARK: - IFileManagerDelegate

extension FileManagerCoordinator: IFileManagerDelegate {

	func openFolder(file: File) {
		showFileManagerScene(file: file)
	}

	func openFile(file: File) {
		showTextEditorScene(file: file)
	}
}

extension FileManagerCoordinator: ITextEditorDelegate {
	func openTodoList(text: String) {
		showTodoListScene(text: text)
	}
}
