import UIKit

protocol IFileManagerViewController: AnyObject {
	func render(viewModel: FileManagerModel.ViewModel)
}

final class FileManagerViewController: UIViewController {
	// MARK: - Dependencies
	
	var interactor: IFileManagerInteractor?
	
	// MARK: - Private properties
	
	private lazy var tableView = makeTableView(
		accessibilityIdentifier: AccessibilityIdentifier.MenuScene.menu.description
	)
	
	private var viewModel: FileManagerModel.ViewModel?
	
	// MARK: - Initialization
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init? (coder: NSCoder) {
		fatalError ("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		interactor?.fetchData()
		setupUI()
		layout()
	}
}

private extension FileManagerViewController {
	
	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		navigationController?.navigationBar.prefersLargeTitles = false
		
		view.addSubview(tableView)
		tableView.register(FileTableViewCell.self, forCellReuseIdentifier: FileTableViewCell.reuseIdentifier)
	}
	
	func makeTableView(accessibilityIdentifier: String) -> UITableView {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = Theme.backgroundColor
		
		tableView.delegate = self
		tableView.dataSource = self
		return tableView
		
	}
}

private extension FileManagerViewController {
	
	func layout() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

extension FileManagerViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let viewModel = viewModel else { return 0 }
		
		return viewModel.files.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: FileTableViewCell.reuseIdentifier,
			for: indexPath
		) as? FileTableViewCell
		
		let file = viewModel?.files[indexPath.row]
		var fileIcon: UIImage?
		
		guard let fileIsFolder = file?.isFolder, let cell = cell, let file = file else { return UITableViewCell() }
		
		fileIcon = fileIsFolder
		? UIImage(systemName: "folder.fill")?.withTintColor(Theme.mainColor, renderingMode: .alwaysOriginal)
		: UIImage(systemName: "doc.fill")?.withTintColor(Theme.mainColor, renderingMode: .alwaysOriginal)
		
		cell.configure(title: file.name, subtitle: file.info ,icon: fileIcon ?? UIImage())
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.performAction(request: .fileSelected(indexPath))
	}
}

extension FileManagerViewController: IFileManagerViewController {
	func render(viewModel: FileManagerModel.ViewModel) {
		self.viewModel = viewModel
		title = viewModel.currentFolderName
		tableView.reloadData()
	}
}
