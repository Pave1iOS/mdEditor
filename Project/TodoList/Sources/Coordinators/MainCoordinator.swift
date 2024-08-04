//
//  MainCoordinator.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 05.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	override func start() {
		showMainMenuScene()
	}
}

private extension MainCoordinator {
	func show(message text: String) {
		let alert = UIAlertController(title: L10n.Message.text, message: text, preferredStyle: .alert)
		let action = UIAlertAction(title: L10n.Ok.text, style: .default)
		
		alert.addAction(action)
		navigationController.present(alert, animated: true)
	}
	
	func showMainMenuScene() {
		let assembler = MenuAssembler()
		let recentFileManager = StubRecentFileManager()
		let viewController = assembler.assembly(recentFileManager: recentFileManager, delegate: self)
		
		viewController.navigationItem.setHidesBackButton(true, animated: true)
		navigationController.pushViewController(viewController, animated: true)
	}
	
	func showTextPreviewScene(file: File) {
		let assembler = TextPreviewAssembler()
		let viewController = assembler.assembly(file: file)
		navigationController.pushViewController(viewController, animated: true)
	}
	
	func runFileManagerFlow() {
		let coordinator = FileManagerCoordinator(navigationController: navigationController)
		addDependency(coordinator)
		
		coordinator.finishFlow = { [weak self, weak coordinator] file in
			guard let self = self, let coordinator = coordinator else { return }
			self.removeDependency(coordinator)
			self.navigationController.popToRootViewController(animated: true)
			
			if let file = file {
				self.showTextPreviewScene(file: file)
			}
		}
		coordinator.start()
	}
}

extension MainCoordinator: IMainMenuDelegate {
	func showAbout() {
		let aboutURL = Bundle.main.url(
			forResource: "About",
			withExtension: "md"
		)!
		
		switch File.parse(url: aboutURL) {
		case .success(let file):
			showTextPreviewScene(file: file)
		case .failure:
			break
		}
	}
	
	func openFile() {
		runFileManagerFlow()
	}
	
	func newFile() {
		show(message: L10n.Menu.newFile)
	}
	
	func openFile(file: File) {
		showTextPreviewScene(file: file)
	}
}
