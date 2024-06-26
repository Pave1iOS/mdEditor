//
//  LoginInteractor.swift
//  mdEditor
//
//  Created by Лилия Андреева on 28.06.2024.
//

import Foundation

protocol ILoginInteractor {
	func login(request: LoginModel.Request)
}

class LoginInteractor: ILoginInteractor {

	// MARK: - Dependencies

	private var presenter: ILoginPresenter?
	private var worker: ILoginWorker

	// MARK: - Initialization

	init(presenter: ILoginPresenter, worker: ILoginWorker) {
		self.presenter = presenter
		self.worker = worker
	}

	// MARK: - Public methods

	func login(request: LoginModel.Request) {
		let result = worker.login(login: request.login, password: request.password)
		let responce = LoginModel.Response(result: result)

		presenter?.present(responce: responce)
	}
}
