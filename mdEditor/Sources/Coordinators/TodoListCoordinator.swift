//
//  TodoListCoordinator.swift
//  TodoList
//
//  Created by Kirill Leonov on 07.12.2023.
//

import UIKit
import TaskManagerPackage

protocol ITodoListCoordinator: ICoordinator {
	func showCreateTaskScene()
	func showTodoListScene()
}

class TodoListCoordinator: ITodoListCoordinator {

	var finishDelegate: ICoordinatorFinishDelegate?
	var navigationController: UINavigationController

	var childCoordinators: [ICoordinator] = []

	private var taskManager: ITaskManager

	internal init( navigationController: UINavigationController, taskManager: ITaskManager ) {
		self.navigationController = navigationController
		self.taskManager = taskManager
	}

	func start() {
		showTodoListScene()
	}

	func showCreateTaskScene() {
		let viewController = CreateTaskAssembler(taskManager: taskManager).assembly { [weak self] in
			self?.navigationController.popViewController(animated: true)
		}
		navigationController.pushViewController(viewController, animated: true)
	}

	func showTodoListScene() {
		let viewController = TodoListAssembler(
			taskManager: taskManager
		).assembly { [weak self] in
			self?.showCreateTaskScene()
		}

		navigationController.pushViewController(viewController, animated: true)
	}
}
