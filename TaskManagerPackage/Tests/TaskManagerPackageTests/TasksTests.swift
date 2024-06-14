import XCTest
@testable import TaskManagerPackage

final class TasksTests: XCTestCase {
	var sut: Task!
	
	// MARK: setUp
	override func setUp() {
		super.setUp()
		
		sut = Task(title: "TestTask")
	}
	
	func test_title_setTitleForTask() {
		XCTAssertTrue(sut.title != "")
	}
	
	func test_completed_setCompletedForTask() {
		sut.completed = true
		
		XCTAssertTrue(sut.completed)
	}
	
	func test_regularTask_setting() {
		let regularTask = RegularTask(title: "RegularTask", completed: true)
				
		XCTAssertTrue(!regularTask.title.isEmpty)
		XCTAssertTrue(regularTask.completed)
	}
	
	func test_importantTask_setting() {
		let importantTask = ImportantTask(title: "ImportantTask", taskPriority: .high, createDate: .now)
		importantTask.completed = true
		
		XCTAssertTrue(!importantTask.title.isEmpty)
		XCTAssertTrue(importantTask.taskPriority.rawValue >= 0)
		XCTAssertTrue(importantTask.completed)
	}
}
