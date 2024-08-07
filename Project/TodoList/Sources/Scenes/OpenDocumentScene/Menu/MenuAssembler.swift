//
//  MenuAssembler.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 07.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import Foundation

final class MenuAssembler {
	func assembly(recentFileManager: IRecentFileManager, delegate: IMenuDelegate) -> MenuViewController {
		let viewController = MenuViewController()
		let presenter = MenuPresenter(viewController: viewController)
		let interctor = MenuInteractor(presenter: presenter, recentFileManager: recentFileManager, delegate: delegate)
		
		viewController.interactor = interctor
		return viewController
	}
}
