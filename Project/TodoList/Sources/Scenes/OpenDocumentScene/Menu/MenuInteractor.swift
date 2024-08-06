//
//  MenuInteractor.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 05.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import Foundation

protocol IMenuDelegate: AnyObject {
	func showAbout()
	func newFile()
	func openFileExplorer()
	func open(file: File)
}

protocol IMenuInteractor {
	func fetchData()
	func performAction(request: MenuModel.Request)
}

final class MenuInteractor: IMenuInteractor {
	
	// MARK: - Public properties
	
	// MARK: - Dependencies
	
	private let presenter: IMenuPresenter
	private let recentFileManager: IRecentFileManager
	private weak var delegate: IMenuDelegate?
	
	// MARK: - Private properties
	
	let menu: [MenuModel.MenuIdentifier] = [.newFile, .openFile, .showAbout]
	
	// MARK: - Initialization
	
	init(presenter: IMenuPresenter, recentFileManager: IRecentFileManager, delegate: IMenuDelegate) {
		self.presenter = presenter
		self.recentFileManager = recentFileManager
		self.delegate = delegate
	}
	
	// MARK: - Public methods
	
	func fetchData() {
		let recentFiles = recentFileManager.getRecentFiles()
		let response = MenuModel.Response(recentFiles: recentFiles, menu: menu)
		presenter.present (response: response)
	}
	
	func performAction(request: MenuModel.Request) {
		switch request {
		case .menuItemSelected(let indexPath):
			let selectedMenuItem = menu[min(indexPath.row, menu.count - 1)]
			switch selectedMenuItem {
			case .openFile:
				delegate?.openFileExplorer()
			case .newFile:
				delegate?.newFile()
			case .showAbout:
				delegate?.showAbout()
			}
		case .recentFileSelected(let indexPath):
			let recentFiles = recentFileManager.getRecentFiles()
			let recentFile = recentFiles[min(indexPath.row, recentFiles.count - 1)]
			
			if case .success(let file) = File.parse(url: recentFile.url) {
				delegate?.open(file: file)
			}
		}
	}
}
