//
//  Queue.swift
//

import Foundation

/// Очередь на основе линейного двунаправленного списка.
struct Queue<T> {

	private var elements = DoublyLinkedList<T>()

	/// Возвращает логическое значение, указывающее, пуста ли очередь.
	var isEmpty: Bool {
		elements.isEmpty
	}

	/// Возвращает количество элементов в очереди.
	var count: Int {
		elements.count
	}

	/// Добавляет элемент в конец очереди.
	/// - Parameter element: элемент для добавления в очередь.
	mutating func enqueue(_ element: T) {
		elements.append(element)
	}

	/// Удаляет и возвращает первый элемент очереди.
	/// - Returns: первый элемент очереди.
	mutating func dequeue() -> T? {
		//		return elements.removeFirst() -- Было так, но у нас elements.pop()
		return elements.pop()
	}

	/// Возвращает первый элемент очереди.
	var peek: T? {
		// elements.first -- было так, но у нас elements.value(at: 0)
		elements.value(at: 0)
	}
}
