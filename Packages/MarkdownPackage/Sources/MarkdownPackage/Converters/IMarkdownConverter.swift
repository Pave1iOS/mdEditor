//
//  File.swift
//  
//
//  Created by Kirill Leonov on 20.03.2024.
//

import Foundation

/// Протокол для конвертера markdown текста.
public protocol IMarkdownConverter {
	associatedtype Result

	/// Конвертирует markdown текст.
	/// - Parameter markdownText: Текст в формате markdown для конвертации.
	/// - Returns: Сконвертированный текст.
	func convert(markdownText: String) -> Result
}
