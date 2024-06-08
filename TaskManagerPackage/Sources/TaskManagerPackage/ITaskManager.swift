//
//  ITaskManager.swift
//  TaskManagerPackage
//
//  Created by Kirill Leonov on 18.11.2023.
//

/// Протокол для TaskManager
public protocol ITaskManager {
	/// Список всех заданий.
	/// - Returns: Массив заданий.
	func allTasks() -> [Task]
	
	/// Список выполненных заданий.
	/// - Returns: Массив заданий.
	func completedTasks() -> [Task]

	/// Список заданий для выполнения.
	/// - Returns: Массив заданий.
	func uncompletedTasks() -> [Task]

	/// Добавление нового задания.
	/// - Parameter task: Задание.
	func addTask(task: Task)

	/// Добавление перечня заданий.
	/// - Parameter tasks: Массив заданий.
	func addTasks(tasks: [Task])

	/// Удаление задания из списка. При вызове метода будут удалены все варианты этого задания по идентичности Task.
	/// - Parameter task: Задание, которое необходимо удалить.
	func removeTask(task: Task)
}

extension TaskManager: ITaskManager { }

extension ImportantTask.TaskPriority: CustomStringConvertible {
	public var description: String {
		switch self {
		case .high:
			return "!!!"
		case .medium:
			return "!!"
		case .low:
			return "!"
		}
	}
}
