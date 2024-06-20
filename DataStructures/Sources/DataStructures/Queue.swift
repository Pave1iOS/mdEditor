public struct Queue<T> {
	
	private var elements = [T]()
	
	/// Возвращает логическое значение, указывающее, пуста ли очередь.
	public var isEmpty: Bool {
		elements.isEmpty
	}
	
	/// Возвращает количество элементов в очереди.
	public var count: Int {
		elements.count
	}
	
	/// Добавляет элемент в конец очереди.
	/// - Parameter element: элемент для добавления в очередь.
	public mutating func enqueue(_ element: T) {
		elements.append(element)
	}
	
	/// Удаляет и возвращает первый элемент очереди.
	/// - Returns: первый элемент очереди.
	public mutating func dequeue() -> T? {
		guard !elements.isEmpty else {
			return nil
		}
		return elements.removeFirst()
	}
	
	/// Возвращает первый элемент очереди.
	public var peek: T? {
		elements.first
	}
}
