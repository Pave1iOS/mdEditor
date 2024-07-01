//
//  TodoListAssembler.swift
//  TodoList
//
//  Created by Kirill Leonov on 04.12.2023.
//

import UIKit
import TaskManagerPackage

final class TodoListAssembler {

	// MARK: - Dependencies

	private let repository: ITaskRepository
	private let taskManager: ITaskManager

	// MARK: - Initialization

	init(repository: ITaskRepository, taskManager: ITaskManager) {
		self.repository = repository
		self.taskManager = taskManager
	}

	// MARK: - Public methods

	func assembly(todoListAddbuttonDidTapped: TodoListAddbuttonDidTapped?) -> TodoListViewController {
		let viewController = TodoListViewController()
//		let taskManager = taskManager
		let sectionForTaskManagerAdapter = SectionForTaskManagerAdapter(taskManager: taskManager)
		let presenter = TodoListPresenter(
			viewController: viewController,
			todoListAddbuttonDidTapped: todoListAddbuttonDidTapped
		)
		let interactor = TodoListInteractor(presenter: presenter, sectionManager: sectionForTaskManagerAdapter)
		viewController.interactor = interactor

		return viewController
	}

}
