//
//  LoginPresenter.swift
//  TodoList
//
//  Created by Kirill Leonov on 04.12.2023.
//

import Foundation

typealias LoginResultClosure = (Result<Void, LoginError>) -> Void

protocol ILoginPresenter {
	func present(responce: LoginModel.Response)
}

class LoginPresenter: ILoginPresenter {

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

	func present(responce: LoginModel.Response) {
		loginResultClosure?(responce.success)
	}
}

extension LoginError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .wrongPassword:
			return "Неверный пароль."
		case .wrongLogin:
			return "Неверный логин."
		case .emptyFields:
			return "Пустые поля логин или пароль."
		case .errorAuth:
			return "Неверный пароль и логин."
		}
	}
}
