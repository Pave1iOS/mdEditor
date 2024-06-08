//
//  TaskManager.swift
//  TaskManagerPackage
//
//  Created by Kirill Leonov on 18.11.2023.
//

/// Менеджер списка заданий.
public final class TaskManager {
	private var taskList = [Task]()

	/// Создание списка заданий.
	/// - Parameter taskList: Набор заданий, которые надо поместить в список.
	public init(taskList: [Task] = [Task]()) {
		self.taskList = taskList
	}

	/// Список всех заданий.
	/// - Returns: Массив заданий.
	public func allTasks() -> [Task] {
		taskList
	}

	/// Список выполненных заданий.
	/// - Returns: Массив заданий.
	public func completedTasks() -> [Task] {
		taskList.filter { $0.completed }
	}

	/// Список заданий для выполнения.
	/// - Returns: Массив заданий.
	public func uncompletedTasks() -> [Task] {
		taskList.filter { !$0.completed }
	}

	/// Добавление нового задания.
	///
	/// Сложность: В среднем O(1) при многих вызовах append(_:) в массиве.
	/// - Parameter task: Задание.
	public func addTask(task: Task) {
		taskList.append(task)
	}

	/// Добавление перечня заданий.
	///
	/// Сложность: В среднем O(m), где m размер добавляемого списка заданий, при многих вызовах append(_:) в массиве.
	/// - Parameter tasks: Массив заданий.
	public func addTasks(tasks: [Task]) {
		taskList.append(contentsOf: tasks)
	}

	/// Удаление задания из списка. При вызове метода будут удалены все варианты этого задания по идентичности Task.
	///
	///Сложность: O(n), где n -- размер списка заданий.
	/// - Parameter task: Задание, которое необходимо удалить.
	public func removeTask(task: Task) {
		taskList.removeAll { $0 === task }
	}
}
