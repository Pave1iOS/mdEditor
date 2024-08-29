//
//  DoublyLinkedList.swift
//

import Foundation

/// Двунаправленный связаный список.
public struct DoublyLinkedList<T> {

	/// Узел двунаправленного связаного списка.
	final class Node<T> {
		/// Хранимые данные.
		var value: T

		/// Ссылка на предыдущий узел если он есть.
		var previous: Node<T>?

		/// Ссылка на следующий узел, если он есть.
		var next: Node<T>?

		init(_ value: T, previous: Node<T>? = nil, next: Node<T>? = nil) {
			self.value = value
			self.previous = previous
			self.next = next
		}
	}

	/// Начало списка.
	private var head: Node<T>?

	/// Конец списка.
	private var tail: Node<T>?

	/// Возвращает количество элементов списка.
	///
	/// Сложность O(1).
	private(set) var count = 0

	/// Возвращает логическое значение, определяющее, пуст ли список.
	///
	/// Сложность O(1).
	var isEmpty: Bool { head == nil && tail == nil }

	/// Инициализация списка с возможностью сразу вложить ему значение.
	/// - Parameter value: Значение, которое мы хотим сохранить в списке.
	public init(_ value: T? = nil) {
		if let value = value {
			let newNode = Node(value)
			head = newNode
			tail = newNode
			count = 1
		}
	}

	/// Добавление в начало списка значения.
	///
	/// Сложность O(1).
	/// - Parameter value: Значение, которое будет добавлено в список.
	public mutating func push(_ value: T) {
		let newNode = Node(value, next: head)
		head?.previous = newNode
		head = newNode
		if tail == nil { tail = head }
		count += 1
	}

	/// Добавление в конец списка значения.
	///
	/// Сложность O(1).
	/// - Parameter value: Значение, которое будет добавлено в список.
	public mutating func append(_ value: T) {
		let newNode = Node(value, previous: tail)
		tail?.next = newNode
		tail = newNode
		if head == nil { head = tail }
		count += 1
	}

	/// Вставка в середину списка значения.
	///
	/// Сложность O(n).
	/// - Parameters:
	///   - value: Значение, которое будет вставлено в список;
	///   - index: Индекс, после которого будет вставлено значение.
	public mutating func insert(_ value: T, after index: Int) {
		guard let currentNode = node(at: index) else { return }
		let nextNode = currentNode.next
		let newNode = Node(value, previous: currentNode, next: nextNode)
		currentNode.next = newNode
		nextNode?.previous = newNode

		if newNode.next == nil {
			tail = newNode
		}

		count += 1
	}

	/// Извлечение значения из начала списка.
	///
	/// Сложность O(1).
	/// - Returns: Извлеченное из списка значение.
	public mutating func pop() -> T? {
		guard let currentHead = head else { return nil }
		head = currentHead.next
		head?.previous = nil
		if head == nil { tail = nil }
		count -= 1
		return currentHead.value
	}

	/// Извлечение значения c конца списка.
	///
	/// Сложность O(1).
	/// - Returns: Извлеченное из списка значение.
	public mutating func removeLast() -> T? {
		guard let currentTail = tail else { return nil }
		tail = currentTail.previous
		tail?.next = nil
		if tail == nil { head = nil }
		count -= 1
		return currentTail.value
	}

	/// Извлечение значения из середины списка.
	/// - Parameter index: Индекс, после которого надо извлечь значение.
	/// - Returns: Извлеченное из списка значение.
	public mutating func remove(after index: Int) -> T? {
		guard let currentNode = node(at: index), let nextNode = currentNode.next else { return nil }
		if nextNode === tail {
			tail = currentNode
			currentNode.next = nil
		} else {
			currentNode.next = nextNode.next
			nextNode.next?.previous = currentNode
		}
		count -= 1
		return nextNode.value
	}

	/// Возвращает значение по индексу.
	/// - Parameter index: Индекс, по которому нужно вернуть значение.
	/// - Returns: Возвращаемое значение.
	public func value(at index: Int) -> T? {
		node(at: index)?.value
	}
}

private extension DoublyLinkedList {
	/// Возвращает узел списка по индексу.
	///
	/// Сложность O(n)
	/// - Parameter index: Индекс, по которому нужно вернуть узел списка.
	/// - Returns: Возвращаемый узел списка.
	private func node(at index: Int) -> Node<T>? {
		guard index >= 0 && index < count else { return nil }
		var currentIndex = 0
		var currentNode: Node<T>?
		if index <= count / 2 {
			currentNode = head
			while currentIndex < index {
				currentNode = currentNode?.next
				currentIndex += 1
			}
		} else {
			currentIndex = count - 1
			currentNode = tail
			while currentIndex > index {
				currentNode = currentNode?.previous
				currentIndex -= 1
			}
		}
		return currentNode
	}
}

extension DoublyLinkedList {
	/// Значение начала списка.
	var headValue: T? {
		head?.value
	}

	/// Значение конца списка.
	var tailValue: T? {
		tail?.value
	}
}

extension DoublyLinkedList: CustomStringConvertible {
	public var description: String {
		var values = [String]()
		var current = head

		while current != nil {
			values.append("\(current!)")
			current = current?.next
		}

		return "size: \(count); values: " + values.joined(separator: " <-> ")
	}
}

extension DoublyLinkedList.Node: CustomStringConvertible {
	public var description: String {
		"\(value)"
	}
}
