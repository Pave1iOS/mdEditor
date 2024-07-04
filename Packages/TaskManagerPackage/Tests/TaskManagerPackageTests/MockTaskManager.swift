//
//  File.swift
//  
//
//  Created by Лилия Андреева on 19.06.2024.
//


@testable import TaskManagerPackage

final class MockTaskManager: ITaskManager {
	
	static let importantTaskHighPriority = ImportantTask(
		title: "MockImportantTaskHighPriority",
		taskPriority: .high
	)
	static let importantTaskMediumPriority = ImportantTask(
		title: "MockImportantTaskMediumPriority",
		taskPriority: .medium
	)
	static let importantTaskLowPriority = ImportantTask(
		title: "MockImportantTaskLowPriority",
		taskPriority: .low
	)
	static let regulatTaskCompleted = RegularTask(title: "MockRegularTaskCompleted", completed: true)
	static let regulartaskUncompleted = RegularTask(title: "MockUncompleted", completed: false)
	
	
	

	func allTasks() -> [TaskManagerPackage.Task] {
		let tasks = [MockTaskManager.importantTaskHighPriority,
					 MockTaskManager.regulatTaskCompleted,
					 MockTaskManager.regulartaskUncompleted,
					 MockTaskManager.importantTaskLowPriority,
					 MockTaskManager.importantTaskMediumPriority
		]
		return tasks
	}

	func completedTasks() -> [TaskManagerPackage.Task] {
		[MockTaskManager.regulatTaskCompleted]
	}

	func uncompletedTasks() -> [TaskManagerPackage.Task] {
		[MockTaskManager.regulartaskUncompleted,
		 MockTaskManager.importantTaskHighPriority,
		 MockTaskManager.importantTaskMediumPriority,
		 MockTaskManager.importantTaskLowPriority]
	}

	func addTask(task: TaskManagerPackage.Task) {
		print("Doesn't exist")
	}

	func addTasks(tasks: [TaskManagerPackage.Task]) {
		print("Doesn't exist")
	}

	func removeTask(task: TaskManagerPackage.Task) {
		print("Doesn't exist")
	}
}
