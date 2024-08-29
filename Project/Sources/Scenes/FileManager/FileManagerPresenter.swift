//
//  FileManagerPresenter.swift
//  MdEditor
//
//  Created by Kirill Leonov on 14.02.2024.
//  Copyright © 2024 leonovka.SwiftBook. All rights reserved.
//

import Foundation

protocol IFileManagerPresenter {
	func present(response: FileManagerModel.Response)
}

final class FileManagerPresenter: IFileManagerPresenter {

	// MARK: - Dependencies

	private weak var viewController: IFileManagerViewController?

	// MARK: - Private properties

	private let dateFormatter = DateFormatter()

	// MARK: - Initialization

	init(viewController: IFileManagerViewController?) {
		self.viewController = viewController
		dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
	}

	// MARK: - Public methods

	func present(response: FileManagerModel.Response) {

		let files: [FileManagerModel.ViewModel.FileModel] = response.files.map {
			FileManagerModel.ViewModel.FileModel(
				name: $0.name,
				info: getFormattedAttributes(file: $0),
				isFolder: $0.isFolder
			)
		}

		let viewModel = FileManagerModel.ViewModel(
			currentFolderName: response.currentFile?.name ?? "/",
			files: files
		)
		viewController?.render(viewModel: viewModel)
	}
}

extension FileManagerPresenter {
	func getFormatted(size: UInt64) -> String {
		var convertedValue = Double(size)
		var multiplyFactor = 0
		let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
		while convertedValue > 1024 {
			convertedValue /= 1024
			multiplyFactor += 1
		}
		return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
	}

	func getFormattedAttributes(file: File) -> String {
		let formattedSize = getFormatted(size: file.size)
		if file.isFolder {
			return "\(dateFormatter.string(from: file.modificationDate)) | <dir>"
		} else {
			return "\"\(file.ext)\" – \(dateFormatter.string(from: file.modificationDate)) | \(formattedSize)"
		}
	}
}
