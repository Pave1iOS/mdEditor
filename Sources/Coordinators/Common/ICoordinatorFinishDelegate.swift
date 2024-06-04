//
//  ICoordinatorFinishDelegate.swift
//  TodoList
//
//  Created by Kirill Leonov on 07.12.2023.
//

import Foundation

/// Делегат координатора при завершения флоу
public protocol ICoordinatorFinishDelegate: AnyObject {
	/// Делегат при завершении координатора флоу
	/// - Parameter coordinator: закрывающийся координатор
	func didFinish(coordinator: ICoordinator)
}
