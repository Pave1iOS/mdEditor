//
//  TextEditorPresenter.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation
import MarkdownPackage

protocol IPdfPreviewPresenter {
	func present(response: PdfPreviewModel.Response)
}

final class PdfPreviewPresenter: IPdfPreviewPresenter {

	private let pdfAuthor: String

	// MARK: - Dependencies

	private weak var viewController: IPdfPreviewViewController?

	// MARK: - Initialization

	init(viewController: IPdfPreviewViewController?, pdfAuthor: String) {
		self.viewController = viewController
		self.pdfAuthor = pdfAuthor
	}

	// MARK: - Public methods

	func present(response: PdfPreviewModel.Response) {
		let pdfTitle = response.fileUrl.lastPathComponent

		let pdf = MarkdownToPdfConverter(
			pageSize: .screen,
			backgroundColor: Theme.backgroundColor,
			pdfAuthor: pdfAuthor,
			pdfTitle: pdfTitle
		).convert(markdownText: response.fileContent)

		let viewModel = PdfPreviewModel.ViewModel(currentTitle: pdfTitle, data: pdf)
		viewController?.render(viewModel: viewModel)
	}
}
