import XCTest
@testable import DataStructures

final class DoubleLinkedListTests: XCTestCase {
    func test_initEmptyDoubleLinkedList_shoultEqual() {
		// MARK: - Arrange
		let sut = makeSut()

		// MARK: - Assert
		XCTAssertTrue(sut.isEmpty)
		XCTAssertEqual(sut.count, 0)
    }

	func test_init_withHead_shouldBeEqual(){
		// MARK: - Arrange
		let sut = DoubleLinkedList(head: Node(value: "Hello"))
		
		// MARK: - Assert
		XCTAssertFalse(sut.isEmpty)
		XCTAssertEqual(sut.count, 1)
	}

	func test_push_with3items_shouldBeEqual() {
		// MARK: - Arrange
		var sut = makeSut()
		
		// MARK: - Act
		sut.push("Item 1")

		// MARK: - Assert
		XCTAssertEqual(sut.count, 1)
		XCTAssertEqual(sut.head?.value, sut.tail?.value)

		// MARK: - Act
		sut.push("Item 2")
	
		// MARK: - Assert
		XCTAssertEqual(sut.count, 2)
		XCTAssertEqual(sut.head?.value, "Item 2")
		XCTAssertEqual(sut.head?.next?.value, "Item 1")
		XCTAssertEqual(sut.tail?.value, "Item 1")

		// MARK: - Act
		sut.push("Item 3")

		// MARK: - Assert
		XCTAssertEqual(sut.count, 3)
		XCTAssertEqual(sut.head?.value, "Item 3")
		XCTAssertEqual(sut.head?.next?.value, "Item 2")
		XCTAssertEqual(sut.tail?.value, "Item 1")
	}

	func test_append_withThreeItems_shouldBeEqual() {
		// MARK: - Arrange
		var sut = makeSut()

		// MARK: - Act
		sut.append("Item 1")

		// MARK: - Assert
		XCTAssertEqual(sut.count, 1)
		XCTAssertEqual(sut.head?.value, sut.tail?.value)

		// MARK: - Act
		sut.append("Item 2")
		// MARK: - Assert
		XCTAssertEqual(sut.count, 2)
		XCTAssertEqual(sut.head?.value, "Item 1")
		XCTAssertEqual(sut.head?.next?.value, "Item 2")
		XCTAssertEqual(sut.tail?.value, "Item 2")

		// MARK: - Act
		sut.append("Item 3")
		// MARK: - Assert
		XCTAssertEqual(sut.count, 3)
		XCTAssertEqual(sut.head?.value, "Item 1")
		XCTAssertEqual(sut.head?.next?.value, "Item 2")
		XCTAssertEqual(sut.tail?.value, "Item 3")
		XCTAssertEqual(sut.head?.next?.next?.value, "Item 3")
		XCTAssertEqual(sut.tail?.previous?.value, "Item 2")
	}
	
	func test_insert_with3Items_shouldBeEqual(){
		// MARK: - Arrange
		var sut = makeSut()
		sut.append("Item 1")
		sut.append("Item 2")
		sut.append("Item 3")

		// MARK: - Act
		sut.insert("Item 4", after: 0)

		// MARK: - Assert
		XCTAssertEqual(sut.count, 4)
		XCTAssertEqual(sut.head?.value, "Item 1")
		XCTAssertEqual(sut.head?.next?.value, "Item 4")
		XCTAssertEqual(sut.head?.next?.next?.value, "Item 2")

		// вставка в конец
		sut.insert("Last Item", after: sut.count - 1)
		XCTAssertEqual(sut.count, 5)

		// вставка по индексу, большему чем количество элементов
		sut.insert("Item 7", after: 7)
		XCTAssertEqual(sut.count, 5)
	}
	
	func test_pop_with3Items_shouldBeEqual() {
		// MARK: - Arrange
		var sut = makeSut()
		sut.append("Item 1")
		sut.append("Item 2")
		sut.append("Item 3")

		// MARK: - Assert
		XCTAssertEqual(sut.count, 3)
		XCTAssertEqual(sut.pop(), "Item 1")
		XCTAssertEqual(sut.count, 2)
		XCTAssertEqual(sut.head?.value, "Item 2")
		XCTAssertEqual(sut.tail?.value, "Item 3")
	}
	
	func test_removeLast_with3Items_shouldBeEqual() {
		// MARK: - Arrange
		var sut = makeSut()
		sut.append("Item 1")
		sut.append("Item 2")
		sut.append("Item 3")

		// MARK: - Assert
		XCTAssertEqual(sut.removeLast(), "Item 3")
		XCTAssertEqual(sut.count, 2)
		XCTAssertEqual(sut.head?.value, "Item 1")
		XCTAssertEqual(sut.tail?.value, "Item 2")
	}
	
	func test_removeAfter_with3Items_shouldBeEqual() {
		// MARK: - Arrange
		var sut = makeSut()
		sut.append("Item 1") //0
		sut.append("Item 2") //1
		sut.append("Item 3") //2

		// MARK: - Assert
		XCTAssertEqual(sut.remove(after: 1), "Item 3")
		XCTAssertEqual(sut.count, 2)
		XCTAssertEqual(sut.head?.value, "Item 1")
		XCTAssertEqual(sut.tail?.value, "Item 3")
		XCTAssertEqual(sut.remove(after: 2), nil)
		
	}
}

extension DoubleLinkedListTests {
	func makeSut() -> DoubleLinkedList<String> {
		DoubleLinkedList()
	}
}
