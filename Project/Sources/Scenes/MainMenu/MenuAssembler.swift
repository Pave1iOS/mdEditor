//
//  MenuAssembler.swift
//  MdEditor
//
//  Created by Kirill Leonov on 15.02.2024.
//  Copyright © 2024 leonovka.SwiftBook. All rights reserved.
//

import Foundation

final class MenuAssembler {
	func assembly(recentFileManager: IRecentFileManager, delegate: IMainMenuDelegate) -> MenuViewController {
		let viewController = MenuViewController()
		let presenter = MenuPresenter(viewController: viewController)
		let interactor = MenuInteractor(presenter: presenter, recentFileManager: recentFileManager, delegate: delegate)
		viewController.interactor = interactor
		return viewController
	}
}
