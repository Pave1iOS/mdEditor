//
//  TodoListViewController.swift
//  TodoList
//
//  Created by Kirill Leonov on 28.11.2023.
//

import UIKit

protocol ITodoListViewController: AnyObject {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: TodoListModel.ViewModel)
}

/// Главный экран приложения.
final class TodoListViewController: UITableViewController {

	// MARK: - Dependencies
	var interactor: ITodoListInteractor?

	// MARK: - Private properties
	private var viewModel = TodoListModel.ViewModel(tasksBySections: [])

	// MARK: - Initialization

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		interactor?.fetchData()
	}
}

// MARK: - Actions

private extension TodoListViewController {
	@objc
	func addTapped() {
		interactor?.createTask()
	}
}

// MARK: - UITableView

extension TodoListViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.tasksBySections.count
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let sectionView = tableView.headerView(forSection: section)
		sectionView?.accessibilityIdentifier = AccessibilityIdentifier.TodoListScene.section(section).description
		return viewModel.tasksBySections[section].title
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewModel.tasksBySections[section]
		return section.tasks.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let task = getTaskForIndex(indexPath)
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		cell.accessibilityIdentifier = AccessibilityIdentifier.TodoListScene.cell(
			section: indexPath.section,
			row: indexPath.row
		).description

		configureCell(cell, with: task)
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didTaskSelected(request: TodoListModel.Request.TaskSelected(indexPath: indexPath))
	}
}

// MARK: - UI setup

private extension TodoListViewController {

	private func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		title = L10n.TodoList.title
		navigationController?.navigationBar.prefersLargeTitles = true

		self.tableView.accessibilityIdentifier = AccessibilityIdentifier.TodoListScene.table.description
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}

	func getTaskForIndex(_ indexPath: IndexPath) -> TodoListModel.ViewModel.Task {
		let tasks = viewModel.tasksBySections[indexPath.section].tasks
		let task = tasks[indexPath.row]
		return task
	}

	func configureCell(_ cell: UITableViewCell, with task: TodoListModel.ViewModel.Task) {
		var contentConfiguration = cell.defaultContentConfiguration()

		cell.tintColor = Theme.accentColor
		cell.backgroundColor = Theme.backgroundColor
		cell.selectionStyle = .none

		switch task {
		case .importantTask(let task):
			let accentText = [NSAttributedString.Key.foregroundColor: Theme.accentColor]
			let taskText = NSMutableAttributedString(string: task.priority + " ", attributes: accentText )
			taskText.append(NSAttributedString(string: task.title))

			contentConfiguration.attributedText = taskText
			contentConfiguration.secondaryText = task.deadLine
			cell.accessoryType = task.completed ? .checkmark : .none
		case .regularTask(let task):
			contentConfiguration.text = task.title
			cell.accessoryType = task.completed ? .checkmark : .none
		}

		cell.contentConfiguration = contentConfiguration
	}
}

// MARK: - IMainViewController

extension TodoListViewController: ITodoListViewController {
	func render(viewModel: TodoListModel.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}
