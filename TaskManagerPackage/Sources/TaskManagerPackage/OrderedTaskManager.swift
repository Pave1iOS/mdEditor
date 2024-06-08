//
//  OrderedTaskManager.swift
//  TaskManagerPackage
//
//  Created by Kirill Leonov on 18.11.2023.
//

import Foundation

/// Предоставляет список заданий, отсортированных по приоритету.
public final class OrderedTaskManager: ITaskManager {

	private let taskManager: ITaskManager


	/// Создание отсортированного по приоритету заданий списка.
	/// - Parameter taskManager: Менеджер списка заданий, который будет предоставлять задания.
	public init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	/// Список всех заданий.
	///
	/// Сложность: O(n log n), где n -- размер списка заданий.
	/// - Returns: Массив заданий.
	public func allTasks() -> [Task] {
		sorted(tasks: taskManager.allTasks())
	}

	/// Список выполненных заданий.
	///
	/// Сложность: O(n log n), где n -- размер списка заданий.
	/// - Returns: Массив заданий.
	public func completedTasks() -> [Task] {
		sorted(tasks: taskManager.completedTasks())
	}

	/// Список заданий для выполнения.
	///
	/// Сложность: O(n log n), где n -- размер списка заданий.
	/// - Returns: Массив заданий.
	public func uncompletedTasks() -> [Task] {
		sorted(tasks: taskManager.uncompletedTasks())
	}

	/// Добавление нового задания.
	///
	/// Сложность: В среднем O(1) при многих вызовах append(_:) в массиве.
	/// - Parameter task: задание.
	public func addTask(task: Task) {
		taskManager.addTask(task: task)
	}

	/// Добавление перечня заданий.
	///
	/// Сложность: В среднем O(m), где m размер добавляемого списка заданий, при многих вызовах append(_:) в массиве.
	/// - Parameter tasks: Массив заданий.
	public func addTasks(tasks: [Task]) {
		taskManager.addTasks(tasks: tasks)
	}

	/// Удаление задания из списка. При вызове метода будут удалены все варианты этого задания по идентичности Task.
	///
	///Сложность: O(n), где n -- размер списка заданий.
	/// - Parameter task: Задание, которое необходимо удалить.
	public func removeTask(task: Task) {
		taskManager.removeTask(task: task)
	}
}

// Приватный extension с методом сортировки
private extension OrderedTaskManager {
	func sorted(tasks: [Task]) -> [Task] {
		tasks.sorted {
			if let task0 = $0 as? ImportantTask, let task1 = $1 as? ImportantTask {
				return task0.taskPriority.rawValue > task1.taskPriority.rawValue
			}
			if $0 is ImportantTask, $1 is RegularTask {
				return true
			}
			return false
		}
	}
}

