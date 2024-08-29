//
//  MarkdownToAttributedTextConverter.swift
//
//  Created by Kirill Leonov on 22.05.2023.
//

import Foundation

public final class MarkdownToAttributedTextConverter: IMarkdownConverter {
	private let markdownToDocument = MarkdownToDocument()
	private let width: CGFloat

	public init(width: CGFloat) {
		self.width = width
	}

	public func convert(markdownText: String) -> NSMutableAttributedString {
		let document = markdownToDocument.convert(markdownText: markdownText)
		
		return convert(document: document)
	}
	
	func convert(document: Document) -> NSMutableAttributedString {
		let visitor = AttributedTextVisitor(width: width)
		
		let result = document.accept(visitor: visitor)
		return result.joined()
	}
}
