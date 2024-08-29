//
//  TextEditorAssembler.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation

final class TextEditorAssembler {
	func assembly(file: File, delegate: ITextEditorDelegate) -> TextEditorViewController {
		let viewController = TextEditorViewController()
		let presenter = TextEditorPresenter(viewController: viewController)
		let interactor = TextEditorInteractor(presenter: presenter, file: file, delegate: delegate)
		viewController.interactor = interactor
		return viewController
	}
}
