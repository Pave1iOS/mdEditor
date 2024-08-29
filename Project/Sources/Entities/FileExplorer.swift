//
//  FileExplorer.swift
//  MdEditor
//
//  Created by Kirill Leonov on 08.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation

protocol IFileExplorer {
	func contentsOfFolder(at url: URL) -> Result<[File], Error>
	func createFolder(at url: URL, withName name: String) -> Result<File, Error>
	func createNewFile(at url: URL, fileName: String) -> Result<File, Error>
}

final class FileExplorer: IFileExplorer {
	// MARK: - Dependencies

	private let fileManager = FileManager.default

	// MARK: - Private properties

	private let fileEncoding = String.Encoding.utf8

	// MARK: - Public methods

	/// Возвращает список всего содержимого URL.
	/// - Parameter url: Путь;
	/// - Returns: массив файлов содержащихся по пути URL или ошибка.
	func contentsOfFolder(at url: URL) -> Result<[File], Error> {
		var files = [File]()

		do {
			let fileNames = try fileManager.contentsOfDirectory(atPath: url.relativePath)
			for fileName in fileNames {
				switch File.parse(url: url.appendingPathComponent("\(fileName)")) {
				case .success(let file):
					files.append(file)
				case .failure(let error):
					return .failure(error)
				}
			}
			return .success(files)
		} catch {
			return .failure(error)
		}
	}

	/// Создать новую папку.
	/// - Parameters:
	///   - url: путь где будет создана новая папка;
	///   - name: имя папки.
	/// - Returns: Файл или ошибка.
	func createFolder(at url: URL, withName name: String) -> Result<File, Error> {
		do {
			let newFolderUrl = url.appendingPathComponent("\(name)")
			try fileManager.createDirectory(at: newFolderUrl, withIntermediateDirectories: true)
			return File.parse(url: newFolderUrl)
		} catch {
			return .failure(error)
		}
	}

	/// Создание нового файла по пути URL.
	/// - Parameters:
	///   - url: Путь, где создаем новый файл;
	///   - fileName: Имя нового файла.
	/// - Returns: Файл или ошибка.
	func createNewFile(at url: URL, fileName: String) -> Result<File, Error> {
		let newFileUrl = url.appendingPathComponent("\(fileName)")
		do {
			try "".write(to: newFileUrl, atomically: true, encoding: fileEncoding)
			return File.parse(url: newFileUrl)
		} catch {
			return .failure(error)
		}
	}
}
