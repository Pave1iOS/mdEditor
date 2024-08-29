//
//  TaskManagerTests.swift
//

import XCTest
@testable import TaskManagerPackage

final class TaskManagerTests: XCTestCase {
	
	private let completedTask = Task(title: "completedTask", completed: true)
	private let uncompletedTask = Task(title: "uncompletedTask", completed: false)
	
	func test_allTasks_add2Tasks_shouldBe2Tasks() {
		let sut = makeSut()

		let allTasks = sut.allTasks()
		
		XCTAssertEqual(allTasks.count, 2, "При получении списка всех задач, получены не все.")
		XCTAssertTrue(allTasks.contains(completedTask), "Отсутствует задача 1")
		XCTAssertTrue(allTasks.contains(uncompletedTask), "Отсутствует задача 2")
	}
	
	func test_completedTasks_add1CompletedAnd1Uncompleted_shouldBe1Task() {
		let sut = makeSut()
		
		let completedTasks = sut.completedTasks()
		
		XCTAssertEqual(completedTasks.count, 1, "В списке завершенных задач должна была остаться 1 задача")
		XCTAssertTrue(
			completedTasks.contains(completedTask),
			"В списке завершенных задач не оказалось завершенной задачи"
		)
		XCTAssertFalse(
			completedTasks.contains(uncompletedTask),
			"В списке завершенных задач попалась незавершенная задача"
		)
	}
	
	func test_uncompletedTasks_add1CompletedAnd1Uncompleted_shouldBe1Task() {
		let sut = makeSut()
		
		let uncompletedTasks = sut.uncompletedTasks()
		
		XCTAssertEqual(uncompletedTasks.count, 1, "В списке незавершенных задач должна была остаться 1 задача")
		XCTAssertTrue(
			uncompletedTasks.contains(uncompletedTask),
			"В списке незавершенных задач не оказалось незавершенных задач"
		)
		XCTAssertFalse(
			uncompletedTasks.contains(completedTask),
			"В списке незавершенных задач попалась завершенная задача"
		)
	}

	func test_addTask_add1Task_shouldBe1Task() {
		let sut = TaskManager()
		
		sut.addTask(task: uncompletedTask)
		let allTasks = sut.allTasks()
		
		XCTAssertTrue(
			allTasks.contains(uncompletedTask),
			"После добавления задачи, она должна быть в списке всех задач"
		)
	}

	func test_addTasks_add2Tasks_shouldBe2Tasks() {
		let sut = TaskManager()
		
		sut.addTasks(tasks: [completedTask, uncompletedTask])
		let allTasks = sut.allTasks()
		
		XCTAssertEqual(allTasks.count, 2, "После добавления 2х задач, они должны быть в списке всех задач")
		XCTAssertTrue(
			allTasks.contains(completedTask),
			"После добавления 2х задач, добавленная завершенная задача отсутствует"
		)
		XCTAssertTrue(
			allTasks.contains(uncompletedTask),
			"После добавления 2х задач, добавленная незавершенная задача отсутствует"
		)
	}
	
	func test_removeTask_add2TasksAndRemove1Task_shouldBe1Task() {
		let sut = makeSut()
		
		sut.removeTask(task: completedTask)
		let allTasks = sut.allTasks()
		
		XCTAssertEqual(
			allTasks.count, 1,
			"После удаления завершенной задачи из спика из 2х задач, осталось больше или меньше 1 задачи."
		)
		XCTAssertFalse(
			allTasks.contains(completedTask),
			"После удаления завершенной задачи из списка из 2х задач, не должно было остаться завершенной задачи."
		)
		XCTAssertTrue(
			allTasks.contains(uncompletedTask),
			"После удаления завершенной задачи из списка из 2х задач, должна была остаться только завершенная задача."
		)
	}
}

// MARK: - TestData

private extension TaskManagerTests {
	func makeSut() -> TaskManager {
		TaskManager(taskList: [completedTask, uncompletedTask])
	}
}
