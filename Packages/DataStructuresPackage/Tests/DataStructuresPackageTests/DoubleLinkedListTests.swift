//
//  DoublyLinkedListTests.swift
//

import XCTest
@testable import DataStructuresPackage

import XCTest

final class DoublyLinkedListTests: XCTestCase {

	func test_init_emptyList_shouldBeEmpty() {
		let sut = DoublyLinkedList<Int>()

		XCTAssertTrue(sut.isEmpty, "Список не пуст.")
		XCTAssertEqual(sut.count, 0, "Пустой список возвращает количество значений не равное 0.")
	}

	func test_init_withSingleElement_shouldBeCorrect() {
		let value = 42

		let sut = DoublyLinkedList(value)

		XCTAssertFalse(sut.isEmpty, "Список с одним элементом не должен быть пуст.")
		XCTAssertEqual(sut.count, 1, "Количество элементов в списке должно быть равно 1.")
	}

	func test_push_twoValues_shouldBeCorrectCount() {
		var sut = DoublyLinkedList<Int>()

		sut.push(1)
		sut.push(2)

		XCTAssertFalse(sut.isEmpty, "Список не должен быть пуст.")
		XCTAssertEqual(sut.count, 2, "Количество элементов в списке должно быть равно 2.")
	}

	func test_append_twoValues_shouldBeCorrectCount() {
		var sut = DoublyLinkedList<Int>()

		sut.append(1)
		sut.append(2)

		XCTAssertFalse(sut.isEmpty, "Список не должен быть пуст.")
		XCTAssertEqual(sut.count, 2, "Количество элементов в списке должно быть равно 2.")
	}

	func test_insert_shouldBeCorrect() {
		var sut = DoublyLinkedList<Int>()
		sut.append(1)
		sut.append(3)

		sut.insert(2, after: 0)

		XCTAssertEqual(sut.headValue, 1, "Голова списка содержит неверное значение.")
		XCTAssertEqual(sut.tailValue, 3, "Хвост списка содержит неверное значение.")
		XCTAssertEqual(sut.count, 3, "В списке неверное количество элементов.")
	}

	func test_pop_fromListWithTwoElements_shouldBeCorrectCountAndValue() {
		var sut = DoublyLinkedList<Int>()
		sut.append(1)
		sut.append(2)

		let poppedValue = sut.pop()

		XCTAssertEqual(poppedValue, 1, "Список вернул неверное значение.")
		XCTAssertEqual(sut.headValue, 2, "Голова списка содержит неверное значение.")
		XCTAssertEqual(sut.tailValue, 2, "Хвост списка содержит неверное значение.")
		XCTAssertEqual(sut.count, 1, "В списке неверное количество элементов.")
	}

	func test_removeLast_fromListWithTwoElements_shouldBeCorrectCountAndValue() {
		var sut = DoublyLinkedList<Int>()
		sut.append(1)
		sut.append(2)

		let removedValue = sut.removeLast()

		XCTAssertEqual(removedValue, 2, "Список вернул неверное значение.")
		XCTAssertEqual(sut.headValue, 1, "Голова списка содержит неверное значение.")
		XCTAssertEqual(sut.tailValue, 1, "Хвост списка содержит неверное значение.")
		XCTAssertEqual(sut.count, 1, "В списке неверное количество элементов.")
	}

	func test_removeAfter_fromListWithThreeElements_shouldBeCorrectCountAndValue() {
		var sut = DoublyLinkedList<Int>()
		sut.append(1)
		sut.append(2)
		sut.append(3)

		let removedValue = sut.remove(after: 0)

		XCTAssertEqual(removedValue, 2, "Список вернул неверное значение.")
		XCTAssertEqual(sut.headValue, 1, "Голова списка содержит неверное значение.")
		XCTAssertEqual(sut.tailValue, 3, "Хвост списка содержит неверное значение.")
		XCTAssertEqual(sut.count, 2, "В списке неверное количество элементов.")
	}

	func test_valueAtIndex_shouldBeCorrectValues() {
		var sut = DoublyLinkedList<Int>()
		sut.append(1)
		sut.append(2)
		sut.append(3)
		sut.append(4)
		sut.append(5)

		let valueAt0 = sut.value(at: 0)
		let valueAt1 = sut.value(at: 1)
		let valueAt2 = sut.value(at: 2)
		let valueAt3 = sut.value(at: 3)
		let valueAt4 = sut.value(at: 4)
		let valueAt5 = sut.value(at: 5)

		XCTAssertEqual(valueAt0, 1, "Список вернул неверное значение по запрошенному индексу.")
		XCTAssertEqual(valueAt1, 2, "Список вернул неверное значение по запрошенному индексу.")
		XCTAssertEqual(valueAt2, 3, "Список вернул неверное значение по запрошенному индексу.")
		XCTAssertEqual(valueAt3, 4, "Список вернул неверное значение по запрошенному индексу.")
		XCTAssertEqual(valueAt4, 5, "Список вернул неверное значение по запрошенному индексу.")
		XCTAssertNil(valueAt5, "Список вернул несуществующее значение.")
	}
}
