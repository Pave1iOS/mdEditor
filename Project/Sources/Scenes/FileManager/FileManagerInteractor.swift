//
//  FileManagerInteractor.swift
//  MdEditor
//
//  Created by Kirill Leonov on 14.02.2024.
//  Copyright © 2024 leonovka.SwiftBook. All rights reserved.
//

import Foundation

/// Делегат по управлению открытием папки и файла. Реализован должен быть в координаторе.
protocol IFileManagerDelegate: AnyObject {

	/// Открыть выбранную папке.
	/// - Parameter file: Ссылка на папку.
	func openFolder(file: File)

	/// Открыть выбранный файл.
	/// - Parameter file: Ссылка на файл.
	func openFile(file: File)
}

protocol IFileManagerInteractor {
	func fetchData()
	func performAction(request: FileManagerModel.Request)
}

final class FileManagerInteractor: IFileManagerInteractor {

	// MARK: - Public properties

	// MARK: - Dependencies

	private let presenter: IFileManagerPresenter
	private let fileExplorer: IFileExplorer
	private weak var delegate: IFileManagerDelegate?
	
	// MARK: - Private properties

	private var fileList: FileManagerModel.Response!
	private let currentFile: File?

	// MARK: - Initialization

	init(
		presenter: IFileManagerPresenter,
		fileExplorer: IFileExplorer,
		delegate: IFileManagerDelegate,
		file: File?
	) {
		self.presenter = presenter
		self.fileExplorer = fileExplorer
		self.delegate = delegate
		self.currentFile = file
	}

	// MARK: - Public methods

	func fetchData() {
		if let currentFile = currentFile {
			switch fileExplorer.contentsOfFolder(at: currentFile.url) {
			case .success(let files):
				fileList = FileManagerModel.Response(currentFile: currentFile, files: files)
			case .failure:
				break
			}
		} else {
			var files = [File]()

			if case .success(let file) = File.parse(url: Endpoints.examples) {
				files.append(file)
			}

			if case .success(let file) = File.parse(url: Endpoints.documents) {
				files.append(file)
			}
			fileList = FileManagerModel.Response(currentFile: nil, files: files)
		}
		presenter.present(response: fileList)
	}

	func performAction(request: FileManagerModel.Request) {
		switch request {
		case .fileSelected(let indexPath):
			let selectedFile = fileList.files[min(indexPath.row, fileList.files.count - 1)]
			if selectedFile.isFolder {
				delegate?.openFolder(file: selectedFile)
			} else {
				delegate?.openFile(file: selectedFile)
			}
		}
	}
}
