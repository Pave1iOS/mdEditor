//
//  MenuViewController.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 05.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import UIKit

protocol IMenuViewController: AnyObject {
	func render(viewModel: MenuModel.ViewModel)
}

final class MenuViewController: UIViewController {
	// MARK: - Dependencies

	var interactor: MenuInteractor?

	// MARK: - Private properties

	private var viewModel: MenuModel.ViewModel?

	private let coverHeight: CGFloat = 200
	private let coverWidth: CGFloat = 100

	private lazy var collectionViewRecentFiles = makeCollectionView(
		accessibilityIdentifier: AccessibilityIdentifier.MenuScene.recentFiles.description
	)

	private lazy var tableViewMenu = makeTableView(
		accessibilityIdentifier: AccessibilityIdentifier.MenuScene.menu.description
	)

	private var constraints: [NSLayoutConstraint] = []

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

		interactor?.fetchData()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		layout()
	}
}

private extension MenuViewController {
	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		title = L10n.Menu.title
		navigationController?.navigationBar.prefersLargeTitles = false

		view.addSubview(collectionViewRecentFiles)
		view.addSubview(tableViewMenu)

		collectionViewRecentFiles.register(
			RecentFileCollectionViewCell.self,
			forCellWithReuseIdentifier: RecentFileCollectionViewCell.reusableIdentifier
		)
		tableViewMenu.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reusableIdentifier)
	}

	func makeFlowLayout() -> UICollectionViewFlowLayout {
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: coverWidth, height: coverHeight)
		layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: Sizes.Padding.normal)
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = Sizes.Padding.double
		layout.minimumInteritemSpacing = Sizes.Padding.double

		return layout
	}

	func makeCollectionView(accessibilityIdentifier: String) -> UICollectionView {
		let layout = makeFlowLayout()

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.isPagingEnabled = true
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = Theme.backgroundColor

		collectionView.accessibilityIdentifier = accessibilityIdentifier
		collectionView.delegate = self
		collectionView.dataSource = self

		return collectionView
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

private extension MenuViewController {
	func layout() {
		NSLayoutConstraint.deactivate(constraints)

		let newConstraints = [
			collectionViewRecentFiles.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionViewRecentFiles.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionViewRecentFiles.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionViewRecentFiles.heightAnchor.constraint(equalToConstant: 200),

			tableViewMenu.topAnchor.constraint(
				equalTo: collectionViewRecentFiles.bottomAnchor,
				constant: Sizes.Padding.normal
			),
			tableViewMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableViewMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableViewMenu.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		]

		NSLayoutConstraint.activate(newConstraints)
		constraints = newConstraints
	}
}

// MARK: - UICollectionViewDelegate
extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let viewModel = viewModel else { return 0 }

		return viewModel.recentFiles.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: RecentFileCollectionViewCell.reusableIdentifier,
			for: indexPath
		) as? RecentFileCollectionViewCell

		let recentFile = viewModel?.recentFiles[indexPath.row]
		cell?.configure(fileName: recentFile?.fileName ?? "", previewText: recentFile?.previewText ?? "")

		return cell ?? UICollectionViewCell()
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		interactor?.performAction(request: .recentFileSelected(indexPath))
	}
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let viewModel = viewModel else { return 0 }

		return viewModel.menu.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: MenuTableViewCell.reusableIdentifier,
			for: indexPath
		) as? MenuTableViewCell

		let menuItem = viewModel?.menu[indexPath.row]
		var menuImage: UIImage?

		switch menuItem?.item {
		case .openFile:
			menuImage = UIImage(systemName: "folder.fill")?.withTintColor(
				Theme.mainColor,
				renderingMode: .alwaysOriginal
			)
		case .newFile:
			menuImage = UIImage(systemName: "doc.fill")?.withTintColor(
				Theme.mainColor,
				renderingMode: .alwaysOriginal
			)
		case .showAbout:
			menuImage = UIImage(systemName: "info.bubble.fill")?.withTintColor(
				Theme.mainColor,
				renderingMode: .alwaysOriginal
			)
		case .none:
			break
		}

		cell?.configure(menuTitle: menuItem?.title ?? "", menuImage: menuImage ?? UIImage())
		
		return cell ?? UITableViewCell()
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.performAction(request: .menuItemSelected(indexPath))
	}
}

extension MenuViewController: IMenuViewController {
	func render(viewModel: MenuModel.ViewModel) {
		self.viewModel = viewModel

		collectionViewRecentFiles.reloadData()
		tableViewMenu.reloadData()
	}
}
