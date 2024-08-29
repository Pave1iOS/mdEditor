//
//  ImportantTaskTests.swift
//  

import XCTest
@testable import TaskManagerPackage

final class ImportantTaskTests: XCTestCase {

	func test_init_shouldHaveCorrect() {
		let currentDate = Date()

		let sut = ImportantTask(title: title, taskPriority: .high, createDate: currentDate)

		XCTAssertEqual(sut.title, title, "Не совпадает имя задания с переданным в инициализатор.")
		XCTAssertEqual(sut.taskPriority, .high, "Не совпадает приоритет задания с переданным в инициализатор.")
		XCTAssertFalse(sut.completed, "Не совпадает статус задания с переданным в инициализатор.")
	}

	func test_deadline_lowPriorityTask() {
		let currentDate = Date()
		let deadLine = Calendar.current.date(byAdding: .day, value: 3, to: currentDate)!

		let sut = ImportantTask(title: title, taskPriority: .low, createDate: currentDate)

		XCTAssertEqual(sut.deadLine, deadLine, "Неверный deadLine для задания с приоритетом low.")
	}

	func test_deadline_mediumPriorityTask() {
		let currentDate = Date()
		let deadLine = Calendar.current.date(byAdding: .day, value: 2, to: currentDate)!

		let sut = ImportantTask(title: title, taskPriority: .medium, createDate: currentDate)

		XCTAssertEqual(sut.deadLine, deadLine, "Неверный deadLine для задания с приоритетом medium.")
	}

	func test_deadline_highPriorityTask() {
		let currentDate = Date()
		let deadLine = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!

		let sut = ImportantTask(title: title, taskPriority: .high, createDate: currentDate)

		XCTAssertEqual(sut.deadLine, deadLine, "Неверный deadLine для задания с приоритетом high.")
	}

	func test_completed_togglePropertyCompleted_propertyCompletedShouldBeTrue() {
		let importantTask = ImportantTask(title: title, taskPriority: .high)

		importantTask.completed.toggle()

		XCTAssertTrue(importantTask.completed, "Задание должно было стать выполненным.")
	}
}

// MARK: - TestData

private extension ImportantTaskTests {
	var title: String {
		"Important Test Task"
	}
}
