//
//  LoginWorker.swift
//  TodoList
//
//  Created by Kirill Leonov on 04.12.2023.
//

import Foundation

protocol ILoginWorker {

	/// Авторизация пользователя.
	/// - Parameters:
	///   - login: Логин пользователя.
	///   - password: Пароль пользователя.
	/// - Returns: Результат прохождения авторизации.
	func login(login: String, password: String) -> Result<Void, LoginError>
}

// Данная обработка ошибок приведена только в учебных целях!
// Никогда на практике нельзя говорить в чем проблема при авторизации.
// Нельзя давать подсказку про верный пароль или верный логин, так как это упрощает взлом.
enum LoginError: Error {
	case wrongPassword
	case wrongLogin
	case errorAuth
	case emptyFields
}

class LoginWorker: ILoginWorker {

	// MARK: - Private properties

	private let validLogin = "Admin"
	private let validPassword = "pa$$32!"

	// MARK: - Public methods

	func login(login: String, password: String) -> Result<Void, LoginError> {
		guard !login.isEmpty, !password.isEmpty else { return .failure(.emptyFields) }

		switch (login == validLogin, password == validPassword) {
		case (true, true):
			return .success(())
		case (false, true):
			return .failure(.wrongLogin)
		case (true, false):
			return .failure(.wrongPassword)
		case (false, false):
			return .failure(.errorAuth)
		}
	}
}

class StubLoginWorker: ILoginWorker {
	func login(login: String, password: String) -> Result<Void, LoginError> {
		.success(())
	}
}
