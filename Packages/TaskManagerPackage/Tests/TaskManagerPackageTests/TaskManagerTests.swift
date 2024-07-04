import XCTest
@testable import TaskManagerPackage

final class TaskManagerTests: XCTestCase {
	
	/// Тест проверяет,  что списко инициализируется пустым
	func test_InitWithEmptyTaskList_ShouldBeEmpty() {
		// MARK: - Arrange
		let sut = makeSut()
		 
		XCTAssertTrue(sut.taskList.isEmpty)
	 }
	
	/// Тест проверяет добавление нескольких задач в список, по результатам он должен сравнить количество добавленых заданий
	func test_allTask_withData_ShouldBeEqual() {
		// MARK: - Arrange
		let sut = makeSut()
		let tasks = [
			Task(title: "Example", completed: true),
			Task(title: "Hi", completed: false)
		]
		
		// MARK: - Act
		sut.addTasks(tasks: tasks)
		
		// MARK: - Assert
		XCTAssertEqual(sut.taskList.count, tasks.count)
	}
	
	/// Тест проверяет добавление одной задачи и статус Выполненного задания
	func test_completedTasks_ShoulBeTrue() {
		// MARK: - Arrange
		let sut = makeSut()
		let task = Task(title: "Example", completed: false)

		// MARK: - Act
		sut.addTask(task: task)
		task.completed = true

		// MARK: - Assert
		XCTAssertTrue(sut.allTasks().contains(where: { $0.completed }))
	}
	
	/// Тест проверяет фильтрацию списка задач на выполненные задачи
	func test_filteredCompletedTask_ShouldBeEqual() {
		// MARK: - Arrange
		let sut = makeSut()
		let tasks = [
			Task(title: "Example", completed: true),
			Task(title: "Hi", completed: false),
			Task(title: "Пример", completed: true)
		]

		// MARK: - Act
		sut.addTasks(tasks: tasks)
		let filteredTasks = sut.completedTasks()
		
		// MARK: - Assert
		XCTAssertEqual(filteredTasks.count, 2)
		XCTAssertFalse(filteredTasks.contains(where: { !$0.completed } ))
	}

	/// Тест проверяет фильтрацию списка задач на невыполненные задачи
	func test_filteredUnCompletedTask_ShouldBeEqual() {
		// MARK: - Arrange
		let sut = makeSut()
		let tasks = [
			Task(title: "Example", completed: true),
			Task(title: "Hi", completed: false),
			Task(title: "Пример", completed: true)
		]

		// MARK: - Act
		sut.addTasks(tasks: tasks)
		let filteredTasks = sut.uncompletedTasks()

		// MARK: - Assert
		XCTAssertEqual(filteredTasks.count, 1)
		XCTAssertFalse(filteredTasks.contains(where: { $0.completed } ))
	}

	/// Тест проверяет статус Невыполненного задания
	func test_filterUnCompletedTasks_ShouldBeFalse() {
		// MARK: - Arrange
		let sut = makeSut()
		let task = Task(title: "Example", completed: false)

		// MARK: - Act
		sut.addTask(task: task)

		// MARK: - Assert
		XCTAssertFalse(sut.allTasks().contains(where: { $0.completed }))
	}
	
	/// Тест проверяет  что добавляется именно то задание, которое мы задали
	func test_addingTask_withData_ShouldBeAddedInTaskList() throws {
		// MARK: - Arrange
		let sut = makeSut()
		let task = Task(title: "Example", completed: true)

		// MARK: - Act
		sut.addTask(task: task)

		// MARK: - Assert
		XCTAssertTrue(sut.allTasks().contains(where: { $0.title == task.title && $0.completed == task.completed }))
    }

	/// Тест проверяет функцию удаления задания из списка
	func test_removeLast_ShouldBeEqual() {
		// MARK: - Arrange
		let sut = makeSut()
		let task = Task(title: "Example", completed: false)

		// MARK: - Act
		sut.addTask(task: task)
		sut.removeTask(task: task)

		// MARK: - Assert
		XCTAssertEqual(sut.taskList.count, 0)
	}
	
	/// Тест проверяет количество заданий при вызове функции Удаения без предварительного добавления задачи в список
	func testRemoveTaskNotExists() {
		// MARK: - Arrange
		let sut = makeSut()
		let task = Task(title: "Задача")

		// MARK: - Act
		sut.removeTask(task: task)

		// MARK: - Assert
		XCTAssertEqual(sut.taskList.count, 0)
	}
	
}

extension TaskManagerTests {
	func makeSut() -> TaskManager {
		TaskManager()
	}
}
