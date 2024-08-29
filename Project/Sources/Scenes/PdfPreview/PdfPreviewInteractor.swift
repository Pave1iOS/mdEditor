//
//  TextEditorInteractor.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation

protocol IPdfPreviewInteractor {
	func fetchData()
}

final class PdfPreviewInteractor: IPdfPreviewInteractor {

	// MARK: - Public properties

	// MARK: - Dependencies

	private var presenter: IPdfPreviewPresenter

	// MARK: - Private properties

	let file: File

	// MARK: - Initialization

	init(presenter: IPdfPreviewPresenter, file: File) {
		self.presenter = presenter
		self.file = file
	}

	// MARK: - Public methods

	func fetchData() {
		let fileContent = String(data: file.contentOfFile() ?? Data(), encoding: .utf8) ?? ""
		let response = PdfPreviewModel.Response(fileUrl: file.url, fileContent: fileContent)
		presenter.present(response: response)
	}
}
