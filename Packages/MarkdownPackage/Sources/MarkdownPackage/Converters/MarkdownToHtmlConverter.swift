//
//  MarkdownToHtmlConverter.swift
//
//  Created by Kirill Leonov on 22.05.2023.
//

import Foundation

public final class MarkdownToHtmlConverter: IMarkdownConverter {
	private let markdownToDocument = MarkdownToDocument()

	public init() { }
	
	public func convert(markdownText: String) -> String {
		let document = markdownToDocument.convert(markdownText: markdownText)

		let visitor = HtmlVisitor()
		let html = document.accept(visitor: visitor)
		
		return makeHtml(html.joined())
	}
	
	func makeHtml(_ text: String) -> String {
		return "<!DOCTYPE html><html><head><style> body {font-size:300%;}</style></head><boby>\(text)</boby></html>"
	}
}
