//
//  TextEditorPresenter.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation
import MarkdownPackage

protocol ITextEditorPresenter {
	func present(response: TextEditorModel.Response)
}

final class TextEditorPresenter: ITextEditorPresenter {

	// MARK: - Dependencies

	private weak var viewController: ITextEditorViewController?

	// MARK: - Initialization

	init(viewController: ITextEditorViewController?) {
		self.viewController = viewController
	}

	// MARK: - Public methods

	func present(response: TextEditorModel.Response) {
		let viewModel: TextEditorModel.ViewModel

		switch response {
		case .initial(let fileUrl, let fileContent):
			let document = MarkdownToDocument().convert(markdownText: fileContent)
			let taskRepository: ITaskRepository = TaskScanner(document: document)
			viewModel = TextEditorModel.ViewModel.initial(
				text: fileContent,
				title: fileUrl.lastPathComponent,
				hasTasks: !taskRepository.getTasks().isEmpty
			)
		case .convert(let text):
			let document = MarkdownToDocument().convert(markdownText: text)
			let taskRepository: ITaskRepository = TaskScanner(document: document)
			let attributedText = MarkdownToRawAttributedTextConverter().convert(markdownText: text)
			viewModel = TextEditorModel.ViewModel.convert(
				text: attributedText,
				hasTasks: !taskRepository.getTasks().isEmpty
			)
		case .print(let text):
			let pdf = MarkdownToPdfConverter(
				pageSize: .a4,
				backgroundColor: .white,
				pdfAuthor: "leonovka",
				pdfTitle: ""
			).convert(markdownText: text)

			viewModel = TextEditorModel.ViewModel.print(data: pdf)
		}

		viewController?.render(viewModel: viewModel)
	}
}
