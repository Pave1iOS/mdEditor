//
//  TextPreviewAssembler.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 07.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import Foundation
import UIKit

final class TextPreviewAssembler {
	func assembly(file: File) -> UIViewController {
		let viewController = MenuViewController()
		
		return viewController
	}
}


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

