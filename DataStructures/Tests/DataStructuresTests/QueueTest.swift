import XCTest
@testable import DataStructures

final class QueueTest: XCTestCase {
	var sut: Queue<Int>!
	
	// Что бы не изменять структуру Queue<T> была создана
	// другая структура которая переводит очередь в обычный массив
	// для использования методов last, first и тд
	struct QueueToArray<T> {
		var queue: Queue<T>
		
		mutating func toArray() -> [T] {
			var array = [T]()
			while let element = queue.dequeue() {
				array.append(element)
			}
			return array
		}
	}
	
	override func setUp() {
		super.setUp()
		sut = Queue()
	}
	
	override func tearDown() {
		super.tearDown()
		sut = nil
	}
	
	func test_isEmpty_queueIsEmpty() {
		XCTAssertTrue(sut.isEmpty, "queue is not empty")
	}
	
	func test_count_numberOfElementsInQueue() {
		XCTAssertTrue(sut.count == 0, "queue count != 0")
	}
	
	func test_enqueue_addsEnElementToTheEndOfTheQueue() {
		sut.enqueue(100)
		sut.enqueue(200)
		
		var convert = QueueToArray(queue: sut)
		let array = convert.toArray()

		XCTAssertEqual(array.last, 200, "last element incorrect")
	}
	
	func test_dequeue_removeAndReturnTheFirstElementOfTheQueue() {
		sut.enqueue(100)
		sut.enqueue(200)
		sut.enqueue(300)
		
		XCTAssertEqual(sut.dequeue(), 100, "first element incorrected")
	}
	
	func test_peek_returnTheFirstElementOfTheQueue() {
		sut.enqueue(100)
		sut.enqueue(200)
		sut.enqueue(300)
		
		XCTAssertEqual(sut.peek, 100, "first element incorrected")
	}
}
