//
//  LoginCordinator.swift
//  TodoList
//
//  Created by Лилия Андреева on 08.06.2024.
//

import UIKit
protocol ILoginCordinator: ICoordinator {
	var finishFlow: (() -> Void)? { get set }
}

final class LoginCordinator: ILoginCordinator {

	// MARK: - Dependencies
	var navigationController: UINavigationController
	var finishFlow: (() -> Void)?

	// MARK: - Initialization
	internal init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Public methods

	func start() {
		showLoginScene()
	}
	func showLoginScene() {
		let viewController = LoginAssembler().assembly(loginResutClousure: handleLoginResult)
		navigationController.pushViewController(viewController, animated: true)
	}

	// MARK: - Private methods

	private func handleLoginResult(result: Result<Void, LoginError>) {
		switch result {
		case .success:
			finishFlow?()
		case .failure(let error):
			showError(message: error.localizedDescription)
		}
	}

	func showError(message: String) {
		let alert: UIAlertController
		alert = UIAlertController(
			title: L10n.LoginError.error,
			message: message,
			preferredStyle: UIAlertController.Style.alert
		)
		let action = UIAlertAction(title: L10n.LoginError.ok, style: .default)
		alert.addAction(action)
		navigationController.present(alert, animated: true, completion: nil)
	}
}
