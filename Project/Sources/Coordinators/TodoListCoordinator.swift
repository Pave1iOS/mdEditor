//
//  TodoListCoordinator.swift
//  TodoList
//
//  Created by Лилия Андреева on 08.06.2024.
//

import UIKit
import TaskManagerPackage

final class TodoListCoordinator: ICoordinator {

	// MARK: - Public properties
	var childCoordinators: [ICoordinator] = []
	// MARK: - Dependencies
	var navigationController: UINavigationController
	private let taskManager: ITaskManager = OrderedTaskManager(taskManager: TaskManager())
	private let repository: ITaskRepository = TaskRepositoryStub()

	// MARK: - Initialization
	internal init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		taskManager.addTasks(tasks: repository.getTasks())
	}

	// MARK: - Public methods

	func start() {
		showTodoListScene()
	}

	func showTodoListScene() {
		let viewController = TodoListAssembler(repository: repository, taskManager: taskManager).assembly()
		navigationController.setViewControllers([viewController], animated: true) //
		// VIP Login остался в стеке вытесниkb при запуске главного флоу
	}

	// MARK: - Private methods
	private func handleCreateTaskButtonDidTapped() {
		navigationController.popViewController(animated: true)
	}
}
