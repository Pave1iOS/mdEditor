//
//  MarkdownToRawAttributedTextConverter.swift
//  
//
//  Created by Kirill Leonov on 18.03.2024.
//

import Foundation

public final class MarkdownToRawAttributedTextConverter: IMarkdownConverter {
	private let markdownToDocument = MarkdownToDocument()

	public init() { }

	public func convert(markdownText: String) -> NSMutableAttributedString {
		let document = markdownToDocument.convert(markdownText: markdownText)

		return convert(document: document)
	}

	func convert(document: Document) -> NSMutableAttributedString {
		let visitor = RawAttributedTextVisitor()

		let result = document.accept(visitor: visitor)
		return result.joined()
	}
}
