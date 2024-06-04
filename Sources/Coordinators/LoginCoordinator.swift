//
//  LoginCoordinator.swift
//  TodoList
//
//  Created by Kirill Leonov on 07.12.2023.
//

import UIKit

protocol ILoginCoordinator: ICoordinator {
	func showLoginScene()
	func showError(message: String)
}

class LoginCoordinator: ILoginCoordinator {

	var childCoordinators: [ICoordinator] = []

	var finishDelegate: ICoordinatorFinishDelegate?

	var navigationController: UINavigationController

	internal init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		showLoginScene()
	}

	func showLoginScene() {
		let viewController = LoginAssembler().assembly { [weak self] result in
			switch result {
			case .success:
				self?.finish()
			case .failure(let error):
				self?.showError(message: error.localizedDescription)
			}
		}
		navigationController.pushViewController(viewController, animated: true)
	}

	func showError(message: String) {
		let alert: UIAlertController
		alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
		let action = UIAlertAction(title: "Ok", style: .default)
		alert.addAction(action)
		navigationController.present(alert, animated: true, completion: nil)
	}
}
