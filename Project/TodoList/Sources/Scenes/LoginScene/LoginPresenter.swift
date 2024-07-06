//
//  LoginPresenter.swift
//  mdEditor
//
//  Created by Лилия Андреева on 28.06.2024.
//

import Foundation
typealias LoginResutClousure = (Result<Void, LoginError>) -> Void

protocol ILoginPresenter {
	func present(responce: LoginModel.Response)
}

class LoginPresenter: ILoginPresenter {

	// MARK: - Dependencies

	private weak var viewController: ILoginViewController?
	var loginResutClousure: LoginResutClousure?

	// MARK: - Initialization

	init(viewController: ILoginViewController?, loginResutClousure: LoginResutClousure?) {
		self.viewController = viewController
		self.loginResutClousure = loginResutClousure
	}

	// MARK: - Public methods

	func present(responce: LoginModel.Response) {
		loginResutClousure?(responce.result)
	}
}

extension LoginError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .wrongPassword:
			return Strings.wrongPassword
		case .wrongLogin:
			return Strings.wrongLogin
		case .emptyFields:
			return Strings.emptyFields
		case .errorAuth:
			return Strings.errorAuth
		}
	}
}
