//
//  Parser.swift
//  MarkdownToHtml
//
//  Created by Kirill Leonov on 16.02.2024.
//

import Foundation

final class Parser {
	func parse(tokens: [Token]) -> Document {
		var tokens = tokens
		var result = [INode]()

		while !tokens.isEmpty {
			var nodes = [INode?]()
			nodes.append(parseHeader(tokens: &tokens))
			nodes.append(parseBlockquote(tokens: &tokens))
			nodes.append(parseParagraph(tokens: &tokens))
			nodes.append(parseCodeBlock(tokens: &tokens))
			nodes.append(parseLineBreak(tokens: &tokens))
			nodes.append(parseTask(tokens: &tokens))
			nodes.append(parseOrderedList(tokens: &tokens))
			nodes.append(parseUnorderedList(tokens: &tokens))
			nodes.append(parseHorizontalLine(tokens: &tokens))
			nodes.append(parseImage(tokens: &tokens))

			let resultNodes = nodes.compactMap { $0 }

			if resultNodes.isEmpty, !tokens.isEmpty {
				tokens.removeFirst()
			} else {
				result.append(contentsOf: resultNodes)
			}
		}

		return Document(result)
	}
}

// MARK: - Private Extension

private extension Parser {
	func parseHeader(tokens: inout [Token]) -> HeaderNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case let .header(level, text) = token {
			tokens.removeFirst()
			return HeaderNode(level: level, children: parseText(token: text))
		}

		return nil
	}

	func parseBlockquote(tokens: inout [Token]) -> BlockquoteNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case let .blockquote(level, text) = token {
			tokens.removeFirst()
			return BlockquoteNode(level: level, children: parseText(token: text))
		}

		return nil
	}

	func parseParagraph(tokens: inout [Token]) -> ParagraphNode? {
		var textNodes = [INode]()

		while !tokens.isEmpty {
			guard let token = tokens.first else { return nil }
			if case let .textLine(text) = token {
				tokens.removeFirst()
				textNodes.append(contentsOf: parseText(token: text))
			} else {
				break
			}
		}

		if !textNodes.isEmpty {
			return ParagraphNode(textNodes)
		}

		return nil
	}

	func parseImage(tokens: inout [Token]) -> ImageNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case let .image(url, size) = token {
			tokens.removeFirst()
			return ImageNode(url: url, size: size)
		}

		return nil
	}

	func parseLineBreak(tokens: inout [Token]) -> LineBreakNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case .lineBreak = token {
			tokens.removeFirst()
			return LineBreakNode()
		}

		return nil
	}

	func parseHorizontalLine(tokens: inout [Token]) -> HorizontalLineNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case .horizontalLine = token {
			tokens.removeFirst()
			return HorizontalLineNode()
		}

		return nil
	}

	func parseText(token: Text) -> [INode] {
		var textNodes = [INode]()
		token.text.forEach { part in
			switch part {
			case .plain(let text):
				textNodes.append(PlainTextNode(text: text))
			case .bold(let text):
				textNodes.append(BoldTextNode(text: text))
			case .italic(let text):
				textNodes.append(ItalicTextNode(text: text))
			case .boldItalic(let text):
				textNodes.append(BoldItalicTextNode(text: text))
			case .strike(let text):
				textNodes.append(StrikeTextNode(text: text))
			case .highlighted(let text):
				textNodes.append(HighlightedTextNode(text: text))
			case .inlineCode(let text):
				textNodes.append(InlineCodeNode(code: text))
			case .escapedChar(let char):
				textNodes.append(EscapedCharNode(char: char))
			case .externalLink(let url, let text):
				textNodes.append(ExternalLinkNode(url: url, text: text))
			case .internalLink(let url):
				textNodes.append(InternalLinkNode(url: url))
			}
		}
		return textNodes
	}

	func parseTask(tokens: inout [Token]) -> TaskNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case let .task(isDone, text) = token {
			tokens.removeFirst()
			return TaskNode(isDone: isDone, children: parseText(token: text))
		}

		return nil
	}

	func parseOrderedList(tokens: inout [Token]) -> OrderedListNode? {
		var nodes = [INode]()
		let currentLevel = 0

		while !tokens.isEmpty {
			guard let token = tokens.first else { return nil }
			if case let .orderedListItem(_, text) = token {
				tokens.removeFirst()
				nodes.append(TextNode(parseText(token: text)))
			} else {
				break
			}
		}

		if !nodes.isEmpty {
			return OrderedListNode(level: currentLevel, children: nodes)
		}

		return nil
	}

	func parseUnorderedList(tokens: inout [Token]) -> UnorderedListNode? {
		var nodes = [INode]()
		let currentLevel = 0

		while !tokens.isEmpty {
			guard let token = tokens.first else { return nil }
			if case let .unorderedListItem(_, text) = token {
				tokens.removeFirst()
				nodes.append(TextNode(parseText(token: text)))
			} else {
				break
			}
		}

		if !nodes.isEmpty {
			return UnorderedListNode(level: currentLevel, children: nodes)
		}

		return nil
	}

	func parseCodeBlock(tokens: inout [Token]) -> CodeBlockNode? {
		var codeLevel = 3
		var codeLang = ""
		var codeText = ""

		if case let .codeBlockMarker(level, lang) = tokens.first {
			tokens.removeFirst()
			codeLevel = level
			codeLang = lang
		} else {
			return nil
		}

		while !tokens.isEmpty {
			guard let token = tokens.first else {
				break
			}

			if case let .codeLine(text) = token {
				tokens.removeFirst()
				codeText += text + "\n"
			} else if case .codeBlockMarker = token {
				tokens.removeFirst()
				break
			} else {
				break
			}
		}

		return CodeBlockNode(level: codeLevel, lang: codeLang, code: codeText)
	}
}
