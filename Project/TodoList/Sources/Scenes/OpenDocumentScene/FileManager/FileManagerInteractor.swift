//
//  FileManagerInteractor.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 05.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import Foundation

protocol IFileManagerDelegate: AnyObject {
	func open(folder: File)
	func open(file: File)
}

protocol IFileManagerInteractor {
	func fetchData()
	func performAction(request: FileManagerModel.Request)
}

final class FileManagerInteractor: IFileManagerInteractor {

	// MARK: - Dependencies

	private let presenter: IFileManagerPresenter
	private let fileExplorer: IFileExplorer
	private weak var delegate: IFileManagerDelegate?

	// MARK: - Private properties

	private var fileList: FileManagerModel.Response?
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
			switch fileExplorer.contentsOfFolder(currentFile.url) {
			case .success(let files):
				fileList = FileManagerModel.Response(currentFile: currentFile, files: files)
			case .failure:
				break
			}
		} else {
			var files: [File] = []

			if let bundleURL = Bundle.main.url(forResource: "Documents", withExtension: nil),
			   case .success(let file) = File.parse(url: bundleURL) {
				files.append(file)
			}

			if let documentsURL = try? FileManager.default.url(
				for: .documentDirectory,
				in: .userDomainMask,
				appropriateFor: nil,
				create: true
			),
				 case .success(let file) = File.parse(url: documentsURL) {
				files.append(file)
			}
			fileList = FileManagerModel.Response(currentFile: nil, files: files)
		}
		guard let fileList = fileList else { return }

		presenter.present(response: fileList)
	}

	func performAction(request: FileManagerModel.Request) {
		switch request {
		case .fileSelected(let indexPath):
			guard let selectedFile = fileList?.files[min(indexPath.row, (fileList?.files.count ?? 0) - 1)]
			else { return }

			selectedFile.isFolder
			? delegate?.open(folder: selectedFile)
			: delegate?.open(file: selectedFile)
		}
	}
}
