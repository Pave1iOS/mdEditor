import XCTest
@testable import DataStructures

final class DoubleLinkedListTests: XCTestCase {
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
		_ = sut.pop()
		
		sut.push(300)
		
		XCTAssertEqual(sut.pop(), 300, "tail equal nil but, tail not equal head")
		XCTAssertEqual(sut.pop(), nil, "the first element in the list is incorrect")
	}
			
	func test_append_addingElementToTheEndOfTheList() {
		sut.append(200)
		
		XCTAssertTrue(sut.removeLast() == 200, "the last element in the list is incorrect")
	}
	
	// not worked
	func test_append_addingElementToTheEndOfTheListIfTailEqualNil() {
		_ = sut.pop()
		sut.append(2)

		XCTAssertEqual(sut.pop(), nil, "head element don't tail") // должно быть head == tail тк 2
	}
	
	func test_insert_addingAnElementToTheMiddleOfTheList() {
		sut.append(200)
		sut.insert(300, after: 1)
		
		XCTAssertEqual(sut.remove(after: 1), 300, "")
	}
	
	func test_pop_removeElementToTheFirstOfList() {
		sut.push(200)
		
		XCTAssertEqual(sut.pop(), 200, "first element don't remove")
	}
	
	func test_removeLast_removeElementToTheEndOfList() {
		sut.append(200)
		
		XCTAssertEqual(sut.removeLast(), 200, "last element don't remove")
	}
	
	func test_remove_removeElementToTheMiddleOfList() {
		sut.append(300)
		sut.insert(200, after: 0)
		
		XCTAssertEqual(sut.remove(after: 0), 200, "middle element incorrect")
	}
	
	func test_description_notIsEmpty() {
		sut.append(200)
		sut.append(300)
		
		XCTAssertFalse(sut.description.isEmpty, "description is empty")
	}
}
