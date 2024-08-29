//
//  OrderedTaskManagerTests.swift
//  

import XCTest
@testable import TaskManagerPackage

final class OrderedTaskManagerTests: XCTestCase {

	func test_allTasks_shouldBe5TaskOrderedByPriority() {
		// Arrange
		let sut = makeSut()
		let validResultTasks: [TaskManagerPackage.Task] = [
			MockTaskManager.highImportantTask,
			MockTaskManager.mediumImportantTask,
			MockTaskManager.lowImportantTask,
			MockTaskManager.completedRegularTask,
			MockTaskManager.uncompletedRegularTask
		]
		
		// Act
		let resultTasks = sut.allTasks()
		
		// Assert
		XCTAssertEqual(resultTasks.count, 5, "При выборке всех задач, ожидалось, что их будет 5 штук.")
		XCTAssertEqual(
			resultTasks,
			validResultTasks,
			"При выборке всех задач, порядок задач не совпал с сортировкой по приоритету."
		)

	}
	
	func test_completedTasks_shouldBeAllCompletedTaskOrderedByPriority() {
		// Arrange
		let sut = makeSut()
		let validResultTasks: [TaskManagerPackage.Task] = [MockTaskManager.completedRegularTask]
		
		// Act
		let resultTasks = sut.completedTasks()
		
		// Assert
		XCTAssertEqual(resultTasks.count, 1, "При выборке завершенных задач, ожидалось, что их будет 1 штука.")
		XCTAssertEqual(
			resultTasks,
			validResultTasks,
			"При выборке завершенных задач, порядок задач не совпал с сортировкой по приоритету."
		)
	}
	
	func test_uncompletedTasks_shouldBeAllUncompletedTaskOrderedByPriority() {
		// Arrange
		let sut = makeSut()
		let validResultTasks: [TaskManagerPackage.Task] = [
			MockTaskManager.highImportantTask,
			MockTaskManager.mediumImportantTask,
			MockTaskManager.lowImportantTask,
			MockTaskManager.uncompletedRegularTask,
		]
		
		// Act
		let resultTasks = sut.uncompletedTasks()
		
		// Assert
		XCTAssertEqual(resultTasks.count, 4, "При выборке незавершенных задач, ожидалось, что их будет 4 штуки.")
		XCTAssertEqual(
			resultTasks,
			validResultTasks,
			"При выборке незавершенных задач, порядок задач не совпал с сортировкой по приоритету."
		)
	}
}

// MARK: - TestData

private extension OrderedTaskManagerTests {
	func makeSut() -> OrderedTaskManager {
		let mockTaskManager = MockTaskManager()
		let sut = OrderedTaskManager(taskManager: mockTaskManager)
		return sut
	}
}
