//
//  TaskRepository.swift
//  TodoList
//
//  Created by Kirill Leonov on 28.11.2023.
//

import Foundation
import TaskManagerPackage

/// Репозиторий для получения заданий.
protocol ITaskRepository {

	/// Получить список заданий.
	/// - Returns: Массив заданий.
	func getTasks() -> [Task]
}

/// Stub Репозитория для получения заданий.
final class TaskRepositoryStub: ITaskRepository {

	/// Возвращает предустановленные данные для приложения.
	/// - Returns: Массив заданий.
	func getTasks() -> [Task] {
		[
			ImportantTask(title: L10n.Task.doHomework, taskPriority: .high),
			RegularTask(title: L10n.Task.doWorkout, completed: true),
			ImportantTask(title: L10n.Task.writeNewTasks, taskPriority: .low),
			RegularTask(title: L10n.Task.solve3Algorithms),
			ImportantTask(title: L10n.Task.goShopping, taskPriority: .medium)
		]
	}
}
