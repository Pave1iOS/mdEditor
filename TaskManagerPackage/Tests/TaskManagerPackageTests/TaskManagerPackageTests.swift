import XCTest
@testable import TaskManagerPackage

final class TaskManagerTests: XCTestCase {
	var sut: TaskManager!
	var task: Task!
	
	override func setUp() {
		super.setUp()
		sut = TaskManager()
		task = Task(title: "TestTask")
	}
	
	// MARK: all task
	func test_allTasks_arrayNotEmpty() {
		var allTask = sut.allTasks()
		
		allTask.append(task)
						
		XCTAssertFalse(allTask.isEmpty, "array is empty")
	}
	
	func test_allTasks_arrayIsEmpty() {
		XCTAssertTrue(sut.allTasks().isEmpty, "array not empty")
	}
	
	
	// MARK: add task(s)
	func test_addTask_appendInArray() {
		sut.addTask(task: task)
		
		XCTAssertFalse(sut.allTasks().isEmpty, "task don't append")
	}
	
	func test_addTasks_appendInArray() {
		sut.addTasks(tasks: [task, task])
		
		XCTAssertTrue(sut.allTasks().count > 1, "tasks don't append")
	}
	
	// MARK: Remove task
	func test_removeTask_removeFromArray() {
		sut.addTask(task: task)
		
		sut.removeTask(task: task)
		
		XCTAssertTrue(sut.allTasks().isEmpty, "task don't append")
	}
	
	// MARK: Completed or uncompleted mark
	func test_completedTask_taskIsMarkedCompleted() {
		task.completed = true
		
		XCTAssertTrue(task.completed, "task not completed")
	}
	
	func test_uncompletedTask_taskIsMarkedUncompleted() {
		task.completed = false
		
		XCTAssertTrue(!task.completed, "task is completed")
	}
	
	// MARK: Filtered task
	func test_completedTask_taskFilteredCompleted() {
		task.completed = true
		
		sut.addTask(task: task)
		
		let completedTask = sut.completedTasks()
		
		XCTAssertFalse(completedTask.isEmpty, "task not completed")
	}
	
	func test_uncompletedTask_taskFilteredUncompleted() {
		task.completed = false
		sut.addTask(task: task)
		
		let uncompletedTask = sut.uncompletedTasks()
		
		XCTAssertFalse(uncompletedTask.isEmpty, "task is completed")
	}
	
}
