//
//  Token.swift
//  MarkdownToHtml
//
//  Created by Kirill Leonov on 13.02.2024.
//

import Foundation

enum Token {
	case header(level: Int, text: Text)
	case blockquote(level: Int, text: Text)
	case codeBlockMarker(level: Int, lang: String)
	case codeLine(text: String)
	case unorderedListItem(level: Int, text: Text)
	case orderedListItem(level: Int, text: Text)
	case textLine(text: Text)
	case image(url: String, size: String)
	case lineBreak
	case horizontalLine
	case task(isDone: Bool, text: Text)
}

struct Text {
	let text: [Part]

	enum Part {
		case plain(text: String)
		case bold(text: String)
		case italic(text: String)
		case boldItalic(text: String)
		case strike(text: String)
		case highlighted(text: String)
		case inlineCode(text: String)
		case escapedChar(char: String)
		case externalLink(url: String, text: String)
		case internalLink(url: String)
	}
}
