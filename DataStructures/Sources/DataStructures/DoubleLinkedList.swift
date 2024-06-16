import Foundation

/// Линейный двунаправленный список.
struct DoubleLinkedList<Element> {
	
	/// Узел линейного двунаправленного списка.
	class Node<T> {
		/// Значение, которое хранит узел.
		var value: T
		
		/// Ссылка на предыдущий узел, если он есть.
		var previous: Node<T>?
		
		/// Ссылка на следующий узел, если он есть.
		var next: Node<T>?
		
		
		/// Инициализатор узла линейного двунаправленного списка.
		/// - Parameters:
		///   - value: Значение для хранения в узле;
		///   - next: Ссылка на следующий узел, если он есть;
		///   - previous: Ссылка на предыдущий узел, если он есть.
		init(_ value: T, previous: Node<T>? = nil, next: Node<T>? = nil) {
			self.value = value
			self.next = next
			self.previous = previous
		}
	}
	
	private var head: Node<Element>?
	private var tail: Node<Element>?
	
	/// Возвращает количество элементов списка.
	///
	/// Сложность O(n).
	///
	/// *TODO: Требует рефакторинга.*
	private(set) var count = 0
	
	/// Возвращает логическое значение, определяющее, пуст ли список.
	/// Сложность O(n).
	var isEmpty: Bool {
		head == nil && tail == nil
	}
	
	/// Инициализатор списка.
	/// - Parameter value: Значение, которое будет добавлено в список.
	init(value: Element? = nil) {
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
	mutating func push(_ value: Element) {
		let newNode = Node(value, next: head)
		
		head?.previous = newNode
		head = newNode
		
		if tail == nil {
			tail = head
		}
		
		count += 1
	}
	
	
	/// Добавление в конец списка значения.
	///
	/// Сложность O(1).
	/// - Parameter value: Значение, которое будет добавлено в список.
	mutating func append(_ value: Element) {
		let newNode = Node(value, previous: tail)
		
		tail?.next = newNode
		tail = newNode
		
		if tail == nil {
			head = tail
		}
		
		count += 1
	}
	
	/// Вставка в середину списка значения.
	///
	/// Сложность O(n).
	/// - Parameters:
	///   - value: Значение, которое будет вставлено в список;
	///   - index: Индекс, после которого будет вставлено значение.
	mutating func insert(_ value: Element, after index: Int) {
		guard let currentNode = node(at: index) else { return }
		
		let nextNode = currentNode.next
		let newNode = Node(value, previous: currentNode, next: nextNode)
		currentNode.next = newNode
		nextNode?.previous = newNode
		
		if newNode.next == nil { tail = newNode }
		
		count += 1
	}
	
	/// Извлечение значения из начала списка.
	///
	/// Сложность O(1).
	/// - Returns: Извлеченное из списка значение.
	mutating func pop() -> Element? {
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
	mutating func removeLast() -> Element? {
		guard let currentTail = tail else { return nil }
		
		tail = currentTail.previous
		tail?.next = nil
		if tail == nil { head = nil }
		
		count -= 1
		
		return currentTail.value
	}
	
	/// Извлечение значения из середины списка.
	/// - Parameter index: Индекс, после которого надо извлеч значение.
	/// - Returns: Извлеченное из списка значение.
	mutating func remove(after index: Int) -> Element? {
		guard
			let currentNode = node(at: index),
			let nextNode = currentNode.next
		else { return nil }
		
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
}

private extension DoubleLinkedList {
	
	/// Возвращает узел списка по индексу.
	///
	/// Сложность O(n)
	/// - Parameter index: Индекс, по которому нужно вернуть узел списка.
	/// - Returns: Возвращаемый узел списка.
	func node(at index: Int) -> Node<Element>? {
		var currentIndex = 0
		var currentNode = head
		
		while currentNode != nil && currentIndex < index {
			currentNode = currentNode?.next
			currentIndex += 1
		}
		
		return currentNode
	}
	
	/// Возвращает значение по указанному индексу
	///
	/// Сложность O(1)
	/// - Parameter index: Индекс, по которому нужно вернуть узел списка.
	func value(at index: Int) -> Element?{
		node(at: index)?.value
	}
}

extension DoubleLinkedList.Node: CustomStringConvertible {
	var description: String {
		"\(value)"
	}
}

extension DoubleLinkedList: CustomStringConvertible {
	var description: String {
		var values = [String]()
		var current = head
		
		while current != nil {
			values.append("\(current!)")
			current = current?.next
		}
		
		return values.joined(separator: " <-> ")
		
	}
}
