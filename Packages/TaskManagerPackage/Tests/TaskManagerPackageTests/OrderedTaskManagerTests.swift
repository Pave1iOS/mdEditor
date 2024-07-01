//
//  File.swift
//  
//
//  Created by Лилия Андреева on 19.06.2024.
//
import XCTest
@testable import TaskManagerPackage

final class OrderedTaskManagerTests: XCTestCase {

	func test_initTaskManaget_ShouldNotNil() {
		// MARK: - Arrange
		let sut = makeSut()

		// MARK: - Assert
		XCTAssertNotNil(sut)
	}

	/// Проверяет количество тасок и их сортировку
	func test_alltasks_ShouldBeEqual() {
		// MARK: - Arrange
		let sut = makeSut()
		let validResult: [TaskManagerPackage.Task] = [
			MockTaskManager.importantTaskHighPriority,
			MockTaskManager.importantTaskMediumPriority,
			MockTaskManager.importantTaskLowPriority,
			MockTaskManager.regulatTaskCompleted,
			MockTaskManager.regulartaskUncompleted,
			
		]

		// MARK: - Act

		let actualTasks = sut.allTasks()
		
		// MARK: - Assert
		XCTAssertEqual(actualTasks.count, validResult.count)
		XCTAssertEqual(actualTasks, validResult)
	}

	/// Проверяет соответствие задания выполненному
	func test_completedTask_shouldBeEqual() {
		// MARK: - Arrange
		let sut = makeSut()
		let validResult = [MockTaskManager.regulatTaskCompleted]

		// MARK: - Act
		let actualTasks = sut.completedTasks()

		// MARK: - Assert
		XCTAssertEqual(actualTasks.count, 1)
		XCTAssertEqual(validResult, actualTasks)
	}

	/// Проверяет соответствие задания не выполненному
	func test_uncompletedTask_shouldBeEqual() {
		// MARK: - Arrange
		let sut = makeSut()
		let validResult = [MockTaskManager.importantTaskHighPriority,
						   MockTaskManager.importantTaskMediumPriority,
						   MockTaskManager.importantTaskLowPriority,
						   MockTaskManager.regulartaskUncompleted
		]

		// MARK: - Act
		let actualTasks = sut.uncompletedTasks()

		// MARK: - Assert
		XCTAssertEqual(actualTasks, validResult)
	}

}

extension OrderedTaskManagerTests {
	func makeSut() -> OrderedTaskManager {
		let mockTaskManager = MockTaskManager()
		let sut = OrderedTaskManager(taskManager: mockTaskManager)
		return sut
	}
}
