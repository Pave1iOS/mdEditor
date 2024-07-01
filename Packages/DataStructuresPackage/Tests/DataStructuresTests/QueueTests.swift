//
//  File.swift
//  
//
//  Created by Лилия Андреева on 20.06.2024.
//

import XCTest
@testable import DataStructures

final class QueueTests: XCTestCase {

	///Проверяет вычисляемые свойство isEmpty
	func test_isEmpty_shoultEqual() {
		// MARK: - Arrange
		let sut = makeSut()

		// MARK: - Assert
		XCTAssertTrue(sut.isEmpty)
	}

	///Проверяет вычисляемые свойство count
	func test_count_shoultEqual() {
		// MARK: - Arrange
		let sut = makeSut()

		// MARK: - Assert
		XCTAssertEqual(sut.count, 0)
	}
	
	func test_enqueue_shouldBeEqual() {
		// MARK: - Arrange
		var sut = makeSut()

		// MARK: - Act
		sut.enqueue("Item 1")
		sut.enqueue("Item 2")

		// MARK: - Assert
		XCTAssertEqual(sut.count, 2)
		XCTAssertEqual(sut.peek, "Item 1")
	}
	
	func test_dequeue_shouldBeEqual() {
		// MARK: - Arrange
		var sut = makeSut()
	
		// MARK: - Act
		sut.enqueue("Item 1")
		sut.enqueue("Item 2")
		
		// MARK: - Assert
		XCTAssertEqual(sut.dequeue(), "Item 1")
		XCTAssertEqual(sut.count, 1)
		XCTAssertEqual(sut.dequeue(), "Item 2")
		XCTAssertEqual(sut.count, 0)
		XCTAssertNil(sut.dequeue())
	}
	
	func test_peek_shoudBeEqual(){
		// MARK: - Arrange
		var sut = makeSut()

		// MARK: - Act
		sut.enqueue("Item 1")
		sut.enqueue("Item 2")

		// MARK: - Assert
		XCTAssertEqual(sut.peek, "Item 1")
	}
}

extension QueueTests {
	func makeSut() -> Queue<String> {
		Queue()
	}
}
