//
//  LoginPresenter.swift
//  TodoList
//
//  Created by Kirill Leonov on 04.12.2023.
//

import Foundation

typealias LoginResultClosure = (Result<Void, LoginError>) -> Void

protocol ILoginPresenter {
	func present(response: LoginModel.Response)
}

final class LoginPresenter: ILoginPresenter {

	// MARK: - Dependencies

	private weak var viewController: ILoginViewController?
	var loginResultClosure: LoginResultClosure?

	// MARK: - Initialization

	init(
		viewController: ILoginViewController?,
		loginResultClosure: LoginResultClosure?
	) {
		self.viewController = viewController
		self.loginResultClosure = loginResultClosure
	}

	// MARK: - Public methods

	func present(response: LoginModel.Response) {
		loginResultClosure?(response.success)
	}
}

extension LoginError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .wrongPassword:
			return L10n.LoginError.wrongPassword
		case .wrongLogin:
			return  L10n.LoginError.wrongLogin
		case .emptyFields:
			return  L10n.LoginError.emptyFields
		case .errorAuth:
			return  L10n.LoginError.errorAuth
		}
	}
}
