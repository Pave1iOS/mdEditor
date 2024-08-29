//
//  QueueTests.swift
//  

import XCTest
@testable import DataStructuresPackage

final class QueueTests: XCTestCase {

	func test_init_emptyQueue_shouldBeEmpty() {
		let sut = Queue<Int>()

		XCTAssertTrue(sut.isEmpty, "Созданная пустая очередь не пуста.")
		XCTAssertEqual(sut.count, 0, "Количество элементов в пустой очереди не равно 0.")
		XCTAssertNil(sut.peek, "Удается получить элемент из пустой очереди.")
	}

	func test_enqueue_twoValues_shouldBeCorrectCountAndFirstValue() {
		var sut = Queue<Int>()

		sut.enqueue(1)
		sut.enqueue(2)

		XCTAssertEqual(sut.count, 2, "Количество поставленных в очередь значений не верно.")
		XCTAssertEqual(sut.peek, 1, "Первый элемент в очереди оказался некорректным.")
	}

	func test_dequeue_onTwoValues_shouldBeCorrectCountAndFirstValue() {
		var sut = Queue<Int>()
		sut.enqueue(1)
		sut.enqueue(2)

		let dequeuedValue = sut.dequeue()

		XCTAssertEqual(dequeuedValue, 1, "Очередь вернула некорректное значение.")
		XCTAssertEqual(sut.count, 1, "Количество поставленных в очередь значений не верно.")
		XCTAssertEqual(sut.peek, 2, "Первый элемент в очереди оказался некорректным.")
	}

	func test_doubleDequeue_onTwoValues_shouldBeCorrectCountAndFirstValue() {
		var sut = Queue<Int>()
		sut.enqueue(1)
		sut.enqueue(2)

		_ = sut.dequeue()
		let secondDequeuedValue = sut.dequeue()

		XCTAssertEqual(secondDequeuedValue, 2, "Очередь вернула некорректное значение.")
		XCTAssertTrue(sut.isEmpty, "Очередь оказалась не пуста.")
		XCTAssertEqual(sut.count, 0, "Количество элементов в пустой очереди не равно 0.")
		XCTAssertNil(sut.peek, "Удается получить элемент из пустой очереди.")
	}

	func test_peek_onTwoValues_shouldBeCorrectCountAndFirstValue() {
		var sut = Queue<Int>()
		sut.enqueue(1)
		sut.enqueue(2)

		let peekedValue1 = sut.peek
		_ = sut.dequeue()
		let peekedValue2 = sut.peek

		XCTAssertEqual(peekedValue1, 1, "Очередь вернула некорректное значение.")
		XCTAssertEqual(peekedValue2, 2, "Очередь вернула некорректное значение.")
		XCTAssertEqual(sut.count, 1, "Количество поставленных в очередь значений не верно.")
	}
}
