//
//  MenuPresenter.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 05.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import Foundation

protocol IMenuPresenter {
	func present(response: MenuModel.Response)
}

final class MenuPresenter: IMenuPresenter {

	// MARK: - Dependencies

	private weak var viewController: IMenuViewController?

	// MARK: - Initialization

	init(viewController: IMenuViewController) {
		self.viewController = viewController
	}

	// MARK: - Public methods

	func present(response: MenuModel.Response) {
		let recentFiles = response.recentFiles.map {
			MenuModel.ViewModel.RecentFile(previewText: $0.previewText, fileName: $0.url.lastPathComponent)
		}

		let menu = response.menu.map {
			MenuModel.ViewModel.MenuItem(title: $0.description, item: $0)
		}

		let viewModel = MenuModel.ViewModel(recentFiles: recentFiles, menu: menu)

		viewController?.render(viewModel: viewModel)
	}
}

extension MenuModel.MenuIdentifier: CustomStringConvertible {
	var description: String {
		switch self {
		case .openFile:
			L10n.Menu.openFile
		case .newFile:
			L10n.Menu.newFile
		case .showAbout:
			L10n.Menu.about
		}
	}
}
