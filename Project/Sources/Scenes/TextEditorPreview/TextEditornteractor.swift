//
//  TextEditorInteractor.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation

protocol ITextEditorDelegate: AnyObject {
	func openTodoList(text: String)
}

protocol ITextEditorInteractor {
	func fetchData()
	func needConvertText(text: String)
	func openTodoList(text: String)
	func print(text: String)
}

final class TextEditorInteractor: ITextEditorInteractor {
	// MARK: - Public properties

	// MARK: - Dependencies

	private var presenter: ITextEditorPresenter
	private weak var delegate: ITextEditorDelegate?

	// MARK: - Private properties

	let file: File

	// MARK: - Initialization

	init(presenter: ITextEditorPresenter, file: File, delegate: ITextEditorDelegate?) {
		self.presenter = presenter
		self.file = file
		self.delegate = delegate
	}

	// MARK: - Public methods

	func fetchData() {
		let fileContent = String(data: file.contentOfFile() ?? Data(), encoding: .utf8) ?? ""
		let response = TextEditorModel.Response.initial(fileUrl: file.url, fileContent: fileContent)
		presenter.present(response: response)
	}

	func needConvertText(text: String) {
		presenter.present(response: TextEditorModel.Response.convert(text: text))
	}

	func openTodoList(text: String) {
		delegate?.openTodoList(text: text)
	}

	func print(text: String) {
		presenter.present(response: TextEditorModel.Response.print(text: text))
	}
}
