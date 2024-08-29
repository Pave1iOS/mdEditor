//
//  MarkdownToDocument.swift
//  
//
//  Created by Kirill Leonov on 24.02.2024.
//

import Foundation

public final class MarkdownToDocument: IMarkdownConverter {
	private let lexer = Lexer()
	private let parser = Parser()

	public init() { }

	public func convert(markdownText: String) -> Document {
		let tokens = lexer.tokenize(markdownText)
		let document = parser.parse(tokens: tokens)

		return document
	}
}
