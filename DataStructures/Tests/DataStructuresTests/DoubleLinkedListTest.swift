import XCTest
@testable import DataStructures

final class DDoubleLinkedListTests: XCTestCase {
	var sut: DoubleLinkedList<Int>!
	
	override func setUp() {
		super.setUp()
		sut = DoubleLinkedList(value: 100)
	}
	
	override func tearDown() {
		super.tearDown()
		sut = nil
	}
	
	func test_isEmpty_arrayNotEmpty() {
		XCTAssertFalse(sut.isEmpty, "array is empty")
	}
	
	func test_push_addingElementToTheBeginningOfTheList() {
		sut.push(300)
		
		XCTAssertTrue(sut.pop() == 300, "the first element in the list is incorrect")
	}
	
	func test_push_addingElementToTheBeginningOfTheListIfTailEqualNil() {
		_ = sut.pop()
		
		sut.push(10)
		XCTAssertEqual(sut.pop(), 10, "tail equal nil but, tail not equal head")
	}
		
	func test_append_addingElementToTheEndOfTheList() {
		sut.append(200)
		
		XCTAssertTrue(sut.removeLast() == 200, "the last element in the list is incorrect")
	}
	
	// not worked
	func test_append_addingElementToTheEndOfTheListIfTailEqualNil() {
		_ = sut.pop()

		sut.append(20)
		XCTAssertEqual(sut.removeLast(), 20, "")
	}
	
}
