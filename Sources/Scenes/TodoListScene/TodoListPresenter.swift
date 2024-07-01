//
//  TodoListPresenter.swift
//  TodoList
//
//  Created by Kirill Leonov on 28.11.2023.
//

import Foundation
import TaskManagerPackage

typealias TodoListAddbuttonDidTapped = () -> Void

protocol ITodoListPresenter {

	/// Отображение экрана со списком заданий.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(response: TodoListModel.Response)

	/// Создание нового задания.
	func createTask()
}

final class TodoListPresenter: ITodoListPresenter {

	// MARK: - Dependencies

	private weak var viewController: ITodoListViewController! // swiftlint:disable:this implicitly_unwrapped_optional
	var todoListAddbuttonDidTapped: TodoListAddbuttonDidTapped?
	// MARK: - Initialization

	init(viewController: ITodoListViewController, todoListAddbuttonDidTapped: TodoListAddbuttonDidTapped?) {
		self.viewController = viewController
		self.todoListAddbuttonDidTapped = todoListAddbuttonDidTapped
	}

	// MARK: - Public methods

	func present(response: TodoListModel.Response) {
		var sections = [TodoListModel.ViewModel.Section]()
		for sectionWithTask in response.data {
			let sectionData = TodoListModel.ViewModel.Section(
				title: sectionWithTask.section.title,
				tasks: mapTasksData(tasks: sectionWithTask.tasks)
			)
			sections.append(sectionData)
		}
		viewController.render(viewModel: TodoListModel.ViewModel(tasksBySections: sections))
	}

	func createTask() {
		todoListAddbuttonDidTapped?()
	}

	// MARK: - Private methods

	private func mapTasksData(tasks: [Task]) -> [TodoListModel.ViewModel.Task] {
		tasks.map { mapTaskData(task: $0) }
	}

	/// Мапинг одного задания из бизнес-модели в задание для отображения
	/// - Parameter task: Задание для преобразования.
	/// - Returns: Преобразованный результат.
	private func mapTaskData(task: Task) -> TodoListModel.ViewModel.Task {
		if let task = task as? ImportantTask {
			let result = TodoListModel.ViewModel.ImportantTask(
				title: task.title,
				completed: task.completed,
				deadLine: "Deadline: \(task.deadLine)",
				priority: "\(task.taskPriority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(
				TodoListModel.ViewModel.RegularTask(
					title: task.title,
					completed: task.completed
				)
			)
		}
	}
}
