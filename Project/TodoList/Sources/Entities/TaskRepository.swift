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

/// Stub Репозиторя для получения заданий.
final class TaskRepositoryStub: ITaskRepository {

	/// Возвращает предустановленные данные для приолжения.
	/// - Returns: Массив заданий.
	func getTasks() -> [Task] {
		[
			ImportantTask(title: L10n.mockDoHomework, taskPriority: .high),
			RegularTask(title: L10n.mockDoWorkout, completed: true),
			ImportantTask(title: L10n.mockWriteNewTasks, taskPriority: .low),
			RegularTask(title: L10n.mockSolve3algorithms),
			ImportantTask(title: L10n.mockGoShopping, taskPriority: .medium)
		]
	}
}
