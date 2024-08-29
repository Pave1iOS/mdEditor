//
//  MockTaskManager.swift
//  

@testable import TaskManagerPackage

final class MockTaskManager: ITaskManager {
	static let highImportantTask = ImportantTask(title: "highImportantTask", taskPriority: .high)
	static let mediumImportantTask = ImportantTask(title: "mediumImportantTask", taskPriority: .medium)
	static let lowImportantTask = ImportantTask(title: "lowImportantTask", taskPriority: .low)
	static let completedRegularTask = RegularTask(title: "completedRegularTask", completed: true)
	static let uncompletedRegularTask = RegularTask(title: "regularTask")
	
	func allTasks() -> [TaskManagerPackage.Task] {
		[
			MockTaskManager.highImportantTask,
			MockTaskManager.lowImportantTask,
			MockTaskManager.completedRegularTask,
			MockTaskManager.mediumImportantTask,
			MockTaskManager.uncompletedRegularTask
		]
	}
	
	func completedTasks() -> [TaskManagerPackage.Task] {
		[MockTaskManager.completedRegularTask]
	}
	
	func uncompletedTasks() -> [TaskManagerPackage.Task] {
		[
			MockTaskManager.highImportantTask,
			MockTaskManager.lowImportantTask,
			MockTaskManager.mediumImportantTask,
			MockTaskManager.uncompletedRegularTask
		]
	}
	
	func addTasks(tasks: [TaskManagerPackage.Task]) {
		fatalError("Not implimented!")
	}
	
	func addTask(task: TaskManagerPackage.Task) {
		fatalError("Not implimented!")
	}

	func removeTask(task: TaskManagerPackage.Task) {
		fatalError("Not implimented!")
	}
}

final class MockTaskManager2: ITaskManager {
	var tasks = [Task]()

	func allTasks() -> [TaskManagerPackage.Task] {
		tasks
	}

	func completedTasks() -> [TaskManagerPackage.Task] {
		fatalError("Not implimented!")
	}

	func uncompletedTasks() -> [TaskManagerPackage.Task] {
		fatalError("Not implimented!")
	}

	func addTasks(tasks: [TaskManagerPackage.Task]) {
		self.tasks.append(contentsOf: tasks)
	}

	func addTask(task: TaskManagerPackage.Task) {
		tasks.append(task)
	}

	func removeTask(task: TaskManagerPackage.Task) {
		tasks.removeAll { $0 === task }
	}
}
