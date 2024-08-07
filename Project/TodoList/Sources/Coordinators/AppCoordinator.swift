//
//  AppCoordinator.swift
//  TodoList
//
//  Created by Лилия Андреева on 08.06.2024.
//

import UIKit
import TaskManagerPackage

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies
	var navigationController: UINavigationController

	// MARK: - Private properties

	// MARK: - Initialization
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Public methods
	override func start() {
		showLoginFlow()
	}

	func showLoginFlow() {
		let coordinator = LoginCordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			guard let self = self else { return }

			self.showMainMenuFlow()
			if let coordinator = coordinator {
				self.removeDependency(coordinator)
			}
			self.navigationController.viewControllers.removeFirst()
		}
		coordinator.start()
	}

	func showMainMenuFlow() {
		let coordinator = MainCoordinator(navigationController: navigationController)
		addDependency(coordinator)
		coordinator.start()
	}
}
