//
//  CreateTaskPresenter.swift
//  TodoList
//
//  Created by Kirill Leonov on 05.12.2023.
//

import Foundation

protocol ICreateTaskPresenter {}

final class CreateTaskPresenter: ICreateTaskPresenter {

	// MARK: - Dependencies

	private weak var viewController: ICreateTaskViewController! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Initialization

	init(viewController: ICreateTaskViewController) {
		self.viewController = viewController
	}
}
