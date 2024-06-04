//
//  ICoordinator.swift
//  TodoList
//
//  Created by Kirill Leonov on 07.12.2023.
//

import UIKit

/// Протокол координаторов.
public protocol ICoordinator: AnyObject {
	/// Дочерние координаторы
	var childCoordinators: [ICoordinator] { get set }

	/// Делегат координатора при завершении сценария
	var finishDelegate: ICoordinatorFinishDelegate? { get set }

	/// Навигейшн координатора
	var navigationController: UINavigationController { get set }

	/// Отображение сцены
	func start()

	/// Закрытие сцены
	func finish()
}

public extension ICoordinator {
	/// Закрытие сцены
	func finish() {
		childCoordinators.removeAll()
		finishDelegate?.didFinish(coordinator: self)
	}
}
