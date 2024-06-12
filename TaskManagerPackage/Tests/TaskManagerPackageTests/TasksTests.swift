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
	
	
}
