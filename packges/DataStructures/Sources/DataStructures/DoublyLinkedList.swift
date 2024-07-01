public final class Node<T> {
	public var value: T
	public var next: Node<T>?
	public var previous: Node<T>?

	public init(value: T, next: Node<T>? = nil, previous: Node<T>? = nil) {
		self.value = value
		self.next = next
		self.previous = previous
	}
}

public struct DoubleLinkedList<T> {
	public var head: Node<T>?
	public var tail: Node<T>?

	// Свойство проверяет является ли список пустым
	public var isEmpty: Bool {
		head == nil
	}
	
	// Свойство размерности связного списка
	public var count: Int {
		var count = 0
		var current = head
		
		while current != nil {
			count += 1
			current = current?.next
		}
		return count
	}

	// Метод добавление элемента в начало
	public mutating func push(_ value: T) {
		let newNode = Node(value: value, next: head)
		head?.previous = newNode
		head = newNode

		if tail == nil {
			tail = head
		}
	}
	// Метод добавления элемента в конец списка
	public mutating func append(_ value: T) {
		guard !isEmpty else {
			push(value)
			return
		}
		let newNode = Node(value: value)
		newNode.previous = tail
		tail!.next = newNode
		tail = newNode
	}
	
	// Метод нахождения ноды
	private func node(at index: Int) -> Node<T>? {
		var currentNode = head
		var currentIndex = 0
		
		while currentNode != nil && currentIndex < index {
			currentNode = currentNode?.next
			currentIndex += 1
		}
		return currentNode
	}

	// Метод вставки внутрь списка
	public mutating func insert(_ value: T, after index: Int) {
		guard let currentNode = node(at: index) else { return }
		guard tail !== currentNode else {
			append(value)
			return
		}
		
		let nextNode = currentNode.next
		let newNode = Node(value: value, next: nextNode, previous: currentNode)
		
		currentNode.next = newNode
		nextNode?.previous = newNode
		
	}

	// Метод удаления первого элемента из списка
	public mutating func pop() -> T? {

		defer {
			head = head?.next
			head?.previous = nil
			
			if isEmpty {
				tail = nil
			}
		}
		return head?.value
	}

	// Метод удаления последнего элемента из списка
	public mutating func removeLast() -> T? {
		defer{
			tail = tail?.previous
			tail?.next = nil
			if tail == nil {
				head = nil
			}
		}
		return tail?.value
	}

	// Метод удаления указанного элемента списка
	public mutating func remove(after index: Int) -> T? {
		guard let currentNode = node(at: index) else { return nil}

		defer{
			if currentNode.previous == nil {
				head = currentNode.next
			} else if currentNode.next === nil {
				tail = currentNode.previous
			}
			currentNode.previous?.next = currentNode.next //предыдущий узел удаляемого узла будет
			//ссылаться на тот узел, который находится после удаляемого
			currentNode.next?.previous = currentNode.previous // следущий узел удаляемого узла
			//будет ссылаться на предыдущий узел удаляемого узла
		}
		return currentNode.next?.value
		
	}

	public init(head: Node<T>? = nil) {
		self.head = head
	}
}
