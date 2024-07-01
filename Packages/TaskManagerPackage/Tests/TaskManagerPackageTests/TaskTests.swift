//
//  File.swift
//  
//
//  Created by Лилия Андреева on 19.06.2024.
//

import XCTest
@testable import TaskManagerPackage

final class TaskTests: XCTestCase {
	
	/// Проверяет инициализацию задачи с заданным названием и статусом выполнения.
	func test_taskInit_ShouldBeEqual() {
		// MARK: - Arrange
		let sut = makeSut()

		// MARK: - Assert
		XCTAssertEqual(sut.title, "Hello")
		XCTAssertFalse(sut.completed)
	}

	/// Проверяет изменение статуса выполнения задачи
	func test_toggleStatus_ShouldBeTrue() {
		// MARK: - Arrange
		let sut = makeSut()

		// MARK: - Act
		sut.completed.toggle()

		// MARK: - Assert
		XCTAssertTrue(sut.completed)
	}

}

extension TaskTests {
	func makeSut() -> Task {
		Task(title: "Hello")
	}
}

final class TaskImportantTaskTests: XCTestCase {
	
	/// Проверяет инициализацию важного задания с заданным названием, приоритетом, датой создания и дедлайном
	func test_initImportantTask_ShouldBeEqual() {
		// MARK: - Arrange
		let sut = makeSut()

		// MARK: - Assert
		XCTAssertEqual(sut.title, "Hello")
		XCTAssertFalse(sut.completed)
		XCTAssertEqual(sut.taskPriority, .medium)
		XCTAssertEqual(
			Calendar.current.compare(
				sut.deadLine,
				to: Calendar.current.date(
					byAdding: .day,
					value: 2,
					to: Date()
				)!,
				toGranularity: .day
			),
			.orderedSame
		)
	}
	
	func test_importantTaskLowPriorityDeadline_shouldBeEqual() {
		// MARK: - Arrange
		let sut = ImportantTask(title: "Hi", taskPriority: .low)
		
		// MARK: - Assert
		XCTAssertEqual(
			Calendar.current.compare(
				sut.deadLine,
				to: Calendar.current.date(
					byAdding: .day,
					value: 3,
					to: Date()
				)!,
				toGranularity: .day
			),
			.orderedSame
		)
	}
	
	func test_importantTaskHighPriorityDeadline_shouldBeEqual() {
		// MARK: - Arrange
		let sut = ImportantTask(title: "Hi", taskPriority: .high)
		
		// MARK: - Assert
		XCTAssertEqual(
			Calendar.current.compare(
				sut.deadLine,
				to: Calendar.current.date(
					byAdding: .day,
					value: 1  ,
					to: Date()
				)!,
				toGranularity: .day
			),
			.orderedSame
		)
	}
}

extension TaskImportantTaskTests {
	func makeSut() -> ImportantTask {
		ImportantTask(title: "Hello", taskPriority: .medium)
	}
}
