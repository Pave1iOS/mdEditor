//
//  LoginModel.swift
//  TodoList
//
//  Created by Kirill Leonov on 24.11.2023.
//

import Foundation

/// LoginModel является NameSpace для отделения ViewData различных экранов друг от друга
enum LoginModel {
	struct Request {
		var login: String
		var password: String
	}

	struct Response {
		var success: Result<Void, LoginError>
	}

	enum ViewModel {
		case success
		case failure(String)
	}
}
