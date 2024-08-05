//
//  MenuPresenter.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 05.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import Foundation

protocol IMenuPresenter {
	func present(response: MenuModel.Response)
}

final class MenuPresenter: IMenuPresenter {
		
	// MARK: - Dependencies
	
	private weak var viewController: IMenuViewController?
		
	// MARK: - Initialization
	
	init(viewController: IMenuViewController) {
		self.viewController = viewController
	}
		
	// MARK: - Public methods
	
	func present(response: MenuModel.Response) {
		let recentFiles = response.recentFiles.map {
			MenuModel.ViewModel.RecentFile(previewText: $0.previewText, fileName: $0.url?.lastPathComponent)
		}
	}
	
	// MARK: - Delegate implementation
	
	// MARK: - Private methods
	
	
	

	
}
