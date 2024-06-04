//
//  CreateTaskAssembler.swift
//  TodoList
//
//  Created by Kirill Leonov on 05.12.2023.
//

import Foundation
import TaskManagerPackage

final class CreateTaskAssembler {

	// MARK: - Dependencies

	private let taskManager: ITaskManager

	// MARK: - Initialization

	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	// MARK: - Public methods

	func assembly(createTaskClosure: @escaping () -> Void) -> CreateTaskViewController {
		let viewController = CreateTaskViewController()
		let presenter = CreateTaskPresenter(viewController: viewController)
		let interactor = CreateTaskInteractor(
			presenter: presenter,
			taskManager: taskManager,
			createTaskClosure: createTaskClosure
		)
		viewController.interactor = interactor

		return viewController
	}
}
