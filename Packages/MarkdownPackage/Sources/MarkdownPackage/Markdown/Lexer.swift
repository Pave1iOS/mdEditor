//
//  Lexer.swift
//  MarkdownToHtml
//
//  Created by Kirill Leonov on 13.02.2024.
//

import Foundation

protocol ILexer {
	func tokenize(_ input: String) -> [Token]
}

/// Lexer анализирует входную строку и преобразует ее в последовательность токенов.
final class Lexer: ILexer {
	func tokenize(_ input: String) -> [Token] {

		let lines = input.components(separatedBy: .newlines)
		var tokens = [Token?]()
		var inCodeBlock = false

		for line in lines {

			if let codeBlockToken = parseCodeBlockMarker(rawText: line) {
				tokens.append(codeBlockToken)
				inCodeBlock.toggle()
				continue
			}

			if !inCodeBlock {
				tokens.append(paresLineBreak(rawText: line))
				tokens.append(parseHeader(rawText: line))
				tokens.append(parseBlockquote(rawText: line))
				tokens.append(parseParagraph(rawText: line))
				tokens.append(parseTask(rawText: line))
				tokens.append(parseUnorderedList(rawText: line))
				tokens.append(parseOrderedList(rawText: line))
				tokens.append(parseHorizontalLine(rawText: line))
			} else {
				tokens.append(.codeLine(text: line))
			}
		}

		return tokens.compactMap{ $0 }
	}
}

private extension Lexer {

	func paresLineBreak(rawText: String) -> Token? {
		if rawText.isEmpty {
			return .lineBreak
		}

		return nil
	}

	func parseHeader(rawText: String) -> Token? {
		let pattern = #"^(#{1,6}) (.*)"#

		let groups = rawText.groups(for: pattern)
		if !groups.isEmpty, groups[0].count == 2 {
			let level = groups[0][0].count
			let text = groups[0][1]
			return .header(level: level, text: parseText(rawText: text))
		}
		return nil
	}

	func parseBlockquote(rawText: String) -> Token? {
		let pattern = #"^(>{1,6})(.*)"#
		let groups = rawText.groups(for: pattern)
		if !groups.isEmpty, groups[0].count == 2 {
			let level = groups[0][0].count
			let text = groups[0][1]
			return .blockquote(level: level, text: parseText(rawText: text))
		}
		return nil
	}

	func parseParagraph(rawText: String) -> Token? {
		if rawText.isEmpty { return nil }
		let notParagraphPattern = #"^(#|>|[\-_\*]{3}|\s*[\-\*\+] |\s*\d+\. ).*"#
		let regex = try? NSRegularExpression(pattern: notParagraphPattern)
		if let notParagraph = regex?.match(rawText), notParagraph == true  { return nil }

		return .textLine(text: parseText(rawText: rawText))
	}

	func parseCodeBlockMarker(rawText: String) -> Token? {
		let pattern = #"^`{2,6}(.*)"#

		if let text = rawText.group(for: pattern) {
			let level = rawText.filter { $0 == "`" }.count
			return .codeBlockMarker(level: level, lang: text)
		}

		return nil
	}

	func parseText(rawText: String) -> Text {
		TextParser().parse(rawText: rawText)
	}

	func parseTask(rawText: String) -> Token? {
		let pattern = #"\s*- \[[ *xX]\]\s+(.*)"#

		if let text = rawText.group(for: pattern) {
			let isDone = !rawText.contains("- [ ]")
			return .task(isDone: isDone, text: parseText(rawText: text))
		}

		return nil
	}

	func parseOrderedList(rawText: String) -> Token? {
		let pattern = #"^(\t*)\d+\.\s+(.+)"#

		let groups = rawText.groups(for: pattern)
		if !groups.isEmpty, groups[0].count == 2 {
			let level = groups[0][0].count
			let text = groups[0][1]
			return .orderedListItem(level: level, text: parseText(rawText: text))
		}

		return nil
	}

	func parseUnorderedList(rawText: String) -> Token? {
		let pattern = #"^(\t*)[\-\+\*]\s+(.+)"#

		let groups = rawText.groups(for: pattern)
		if !groups.isEmpty, groups[0].count == 2 {
			let level = groups[0][0].count
			let text = groups[0][1]
			return .unorderedListItem(level: level, text: parseText(rawText: text))
		}

		return nil
	}

	func parseHorizontalLine(rawText: String) -> Token? {
		let pattern = #"^([\-_\*]{3})"#

		if rawText.group(for: pattern) != nil {
			return .horizontalLine
		}

		return nil
	}
}
