//
//  LoginAssembler.swift
//  TodoList
//
//  Created by Kirill Leonov on 04.12.2023.
//

import UIKit

final class LoginAssembler {
	func assembly(loginResultClosure: LoginResultClosure?) -> LoginViewController {
		let viewController = LoginViewController()
		let presenter = LoginPresenter(
			viewController: viewController,
			loginResultClosure: loginResultClosure
		)
		let worker = LoginWorker()
		let interactor = LoginInteractor(
			presenter: presenter,
			worker: worker
		)
		viewController.interactor = interactor
		return viewController
	}
}
