//
//  LoginAssembler.swift
//  mdEditor
//
//  Created by Лилия Андреева on 28.06.2024.
//

import Foundation

final class LoginAssembler {
	func assembly(loginResutClousure: LoginResutClousure?) -> LoginViewController {
		let viewController = LoginViewController()
		let presenter = LoginPresenter(viewController: viewController, loginResutClousure: loginResutClousure)
		let worker = StubLoginWorker()// LoginWorker()
		let interactor = LoginInteractor(presenter: presenter, worker: worker)
		viewController.interactor = interactor
		return viewController
	}
}
