//
//  FileManager.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 01.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import Foundation

enum FileExplorerError: Error {
	case wrongAttribute
	case wrongOpenFolder
	
	var description: String {
		switch self {
		case .wrongAttribute:
			"Не верно прописаны атрибуты"
		case .wrongOpenFolder:
			"Не удалось открыть папку"
		}
	}
}

protocol IFileExplorer {
	func contentsOfFolder(_ url: URL) -> Result<[File], Error>
	func create(folderIn url: URL, withName name: String) -> Result<File, Error>
	func create(fileIn url: URL, withName name: String) -> Result<File, Error>
}

final class FileExplorer: IFileExplorer {
	
	private let fileManager = FileManager.default
	private let fileEncoding = String.Encoding.utf8
	
	/// Получить содержимое папки
	func contentsOfFolder(_ url: URL) -> Result<[File], Error> {
		var files: [File] = []
		
		do {
			let fileNames = try fileManager.contentsOfDirectory(atPath: url.relativePath)
			for fileName in fileNames {
				switch File.parse(url: url.appendingPathComponent("\(fileName)")) {
				case .success(let file):
					files.append(file)
				case .failure(_):
					return .failure(FileExplorerError.wrongOpenFolder)
				}
			}
			return .success(files)
		} catch {
			return .failure(FileExplorerError.wrongAttribute)
		}
	}
	
	/// Создать папку
	func create(folderIn url: URL, withName name: String) -> Result<File, Error> {
		do {
			let newFolderUrl = url.appendingPathComponent("\(name)")
			try fileManager.createDirectory(at: newFolderUrl, withIntermediateDirectories: true)
			return File.parse(url: newFolderUrl)
		} catch {
			return .failure(FileExplorerError.wrongAttribute)
		}
	}
	
	/// Создать файл
	func create(fileIn url: URL, withName name: String) -> Result<File, Error> {
		let newFileUrl = url.appendingPathComponent("\(name)")
		do {
			try "".write(to: newFileUrl, atomically: true, encoding: .utf8)
			return File.parse(url: newFileUrl)
		} catch {
			return .failure(FileExplorerError.wrongAttribute)
		}
	}
}
