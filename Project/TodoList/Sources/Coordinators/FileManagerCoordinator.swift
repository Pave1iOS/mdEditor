//
//  FileManagerCoordinator.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 05.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import UIKit

protocol IFileManagerCoordinator: ICoordinator {
	var finishFlow: ((File?) -> Void)? { get set }
}

final class FileManagerCoordinator: NSObject, IFileManagerCoordinator, UINavigationControllerDelegate {
	// MARK: - Dependencies
	
	private let navigationController: UINavigationController
	private var topViewController: UIViewController?
	
	// MARK: - Internal properties
	
	var finishFlow: ((File?) -> Void)?
	
	// MARK: - Initialization
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		
		super.init()
		
		self.topViewController = navigationController.topViewController
		
		navigationController.delegate = self
	}
		
	// MARK: - Public methods
	
	func start() {
		showFileManagerScene(file: nil)
	}
	
	// метод который закроет все viewController в стеке при возвращении на главный экран
	// для него подписываем класс на NSObject и UINavigationControllerDelegate
	func navigationController(
		_ navigationController: UINavigationController,
		didShow viewController: UIViewController,
		animated: Bool
	) {
		if viewController === topViewController {
			finishFlow?(nil)
		}
	}
	
	// MARK: - Private methods
	
	private func showFileManagerScene(file: File?) {
		let assembler = FileManagerAssembler()
		let viewController = assembler.assembly(fileExplorer: FileExplorer(), delegate: self, file: file)
		navigationController.pushViewController(viewController, animated: true)
	}
	
	private func showTextPreviewScene(file: File) {
		let assembler = TextPreviewAssembler()
		let viewController = assembler.assembly(file: file)
		navigationController.pushViewController(viewController, animated: true)
	}
}

extension FileManagerCoordinator: IFileManagerDelegate {
	func open(folder: File) {
		showFileManagerScene(file: folder)
	}
	
	func open(file: File) {
		showTextPreviewScene(file: file)
	}
}
