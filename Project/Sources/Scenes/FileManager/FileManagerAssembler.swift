//
//  FileManagerAssembler.swift
//  MdEditor
//
//  Created by Kirill Leonov on 14.02.2024.
//  Copyright © 2024 leonovka.SwiftBook. All rights reserved.
//

import Foundation

final class FileManagerAssembler {
	func assembly(fileExplorer: IFileExplorer, delegate: IFileManagerDelegate, file: File?) -> FileManagerViewController {
		let viewController = FileManagerViewController()
		let presenter = FileManagerPresenter(viewController: viewController)
		let interactor = FileManagerInteractor(
			presenter: presenter,
			fileExplorer: fileExplorer,
			delegate: delegate,
			file: file
		)
		viewController.interactor = interactor
		return viewController
	}
}
