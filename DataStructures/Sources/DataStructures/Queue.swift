struct Queue<T> {
	
	private var elements = [T]()
	
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
		guard !elements.isEmpty else {
			return nil
		}
		return elements.removeFirst()
	}
	
	/// Возвращает первый элемент очереди.
	var peek: T? {
		elements.first
	}
}
