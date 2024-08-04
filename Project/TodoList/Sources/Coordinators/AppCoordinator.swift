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
//		showLoginFlow()
		showOpenDocumentDir()
	}
	#warning("удалить и исправить")
	func showOpenDocumentDir() {
		navigationController.pushViewController(OpenDocumentViewController(), animated: true)
	}

	func showLoginFlow() {
		let coordinator = LoginCordinator(navigationController: navigationController)
		addDependency(coordinator)
		coordinator.finishFlow = { [weak self, weak coordinator] in
			self?.showTodoListFlow()
			coordinator.map { self?.removeDependency($0) }
		}
		coordinator.start()
	}

	func showTodoListFlow() {
		let coordinator = TodoListCoordinator(navigationController: navigationController)
		addDependency(coordinator)
		coordinator.start()
	}
}
