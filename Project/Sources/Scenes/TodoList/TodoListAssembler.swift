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

	private let taskManager: ITaskManager

	// MARK: - Initialization

	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	// MARK: - Public methods

	func assembly(createTaskClosure: (() -> Void)? ) -> TodoListViewController {
		let viewController = TodoListViewController()
		let sectionForTaskManagerAdapter = SectionForTaskManagerAdapter(taskManager: taskManager)
		let presenter = TodoListPresenter(viewController: viewController)
		let interactor = TodoListInteractor(
			presenter: presenter,
			sectionManager: sectionForTaskManagerAdapter,
			createTaskClosure: createTaskClosure
		)
		viewController.interactor = interactor

		return viewController
	}
}
