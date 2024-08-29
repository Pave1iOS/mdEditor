//
//  RawAttributedTextVisitor.swift
//  
//
//  Created by Kirill Leonov on 18.03.2024.
//

import Foundation

import UIKit

public final class RawAttributedTextVisitor: IVisitor {

	public init() { }

	public func visit(node: Document) -> [NSMutableAttributedString] {
		visitChildren(of: node)
	}

	public func visit(node: HeaderNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode(String(repeating: "#", count: node.level) + " ")
		let text = visitChildren(of: node).joined()

		let textAttributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.headerColor[node.level - 1],
			.font: UIFont.systemFont(ofSize: Appearance.headerSize[node.level - 1])
		]

		let sizeAttributes : [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: Appearance.headerSize[node.level - 1])
		]

		text.addAttributes(textAttributes, range: NSRange(0..<text.length))
		code.addAttributes(sizeAttributes, range: NSRange(0..<code.length))

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.lineBreak)

		return result
	}

	public func visit(node: ParagraphNode) -> NSMutableAttributedString {
		let result = visitChildren(of: node).joined()
		result.append(String.lineBreak)
		return result
	}

	public func visit(node: TextNode) -> NSMutableAttributedString {
		return visitChildren(of: node).joined()
	}

	public func visit(node: BlockquoteNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode(String(repeating: ">", count: node.level) + " ")
		let text = visitChildren(of: node).joined()

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.lineBreak)

		return result
	}

	public func visit(node: PlainTextNode) -> NSMutableAttributedString {
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textColor,
			.font: UIFont.systemFont(ofSize: Appearance.textSize)
		]

		let result = NSMutableAttributedString(string: node.text, attributes: attributes)
		return result
	}

	public func visit(node: BoldTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("**")

		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textBoldColor,
			.font: UIFont.boldSystemFont(ofSize:  Appearance.textSize)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)

		return result
	}

	public func visit(node: BoldItalicTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("***")

		let font: UIFont

		if let fontDescriptor = UIFontDescriptor
			.preferredFontDescriptor(withTextStyle: .body)
			.withSymbolicTraits([.traitBold, .traitItalic]) {
			font = UIFont(descriptor: fontDescriptor, size:  Appearance.textSize)
		} else {
			font = UIFont.boldSystemFont(ofSize:  Appearance.textSize)
		}

		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textBoldItalicColor,
			.font: font
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)

		return result
	}

	public func visit(node: ItalicTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("*")

		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textItalicColor,
			.font: UIFont.italicSystemFont(ofSize: Appearance.textSize)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)

		return result
	}

	public func visit(node: StrikeTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("~~")

		let attribute: [NSAttributedString.Key: Any] = [
			.strikethroughStyle : NSUnderlineStyle.single.rawValue,
			.foregroundColor: Appearance.textStrikeColor,
			.strikethroughColor: UIColor.red,
			.font: UIFont.systemFont(ofSize: Appearance.textSize)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attribute)

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)

		return result
	}

	public func visit(node: HighlightedTextNode) -> NSMutableAttributedString {
		let code = makeMarkdownCode("==")

		let attribute: [NSAttributedString.Key: Any] = [
			.backgroundColor: Appearance.highlightedTextBackground,
			.foregroundColor: Appearance.textHighlightedColor,
			.font: UIFont.systemFont(ofSize: Appearance.textSize)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attribute)

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)

		return result
	}

	public func visit(node: EscapedCharNode) -> NSMutableAttributedString {
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textColor,
			.font: UIFont.systemFont(ofSize: Appearance.textSize)
		]

		let result = makeMarkdownCode("\\")
		result.append(NSMutableAttributedString(string: node.char, attributes: attributes))
		return result
	}

	public func visit(node: LineBreakNode) -> NSMutableAttributedString {
		String.lineBreak
	}

	public func visit(node: ImageNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}

	public func visit(node: HorizontalLineNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		result.append(makeMarkdownCode("---"))
		result.append(String.lineBreak)
		return result
	}

	public func visit(node: OrderedListNode) -> NSMutableAttributedString {
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textColor,
			.font: UIFont.monospacedDigitSystemFont(ofSize: Appearance.textSize, weight: .medium)
		]
		let tab = NSMutableAttributedString(
			string: String(repeating: "\t", count: node.level),
			attributes: attributes
		)

		let items = visitChildren(of: node)

		let result = NSMutableAttributedString()
		var index = 0
		items.forEach {
			index += 1
			result.append(tab)
			result.append(makeMarkdownCode("\(index). "))
			result.append($0)
			result.append(String.lineBreak)
		}
		return result
	}

	public func visit(node: UnorderedListNode) -> NSMutableAttributedString {
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textColor,
			.font: UIFont.monospacedDigitSystemFont(ofSize: Appearance.textSize, weight: .medium)
		]
		let tab = NSMutableAttributedString(
			string: String(repeating: "\t", count: node.level),
			attributes: attributes
		)

		let items = visitChildren(of: node)

		let result = NSMutableAttributedString()
		items.forEach {
			result.append(tab)
			result.append(makeMarkdownCode("- "))
			result.append($0)
			result.append(String.lineBreak)
		}
		return result
	}

	public func visit(node: ExternalLinkNode) -> NSMutableAttributedString {
		let result = makeMarkdownCode("[")

		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.linkColor,
			.font: UIFont.italicSystemFont(ofSize: Appearance.textSize),
			.underlineStyle: NSUnderlineStyle.single.rawValue
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)
		let link = NSMutableAttributedString(string: node.url, attributes: attributes)

		if let url = URL(string: node.url) {
			link.addAttribute(.link, value: url, range:  NSRange(0..<link.length))
		}

		result.append(text)
		result.append(makeMarkdownCode("]("))
		result.append(link)
		result.append(makeMarkdownCode(")"))
		return result
	}

	public func visit(node: InternalLinkNode) -> NSMutableAttributedString {
		let result = makeMarkdownCode("[[")

		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.linkColor,
			.font: UIFont.italicSystemFont(ofSize: Appearance.textSize),
			.underlineStyle: NSUnderlineStyle.single.rawValue
		]
		let url = NSMutableAttributedString(string: node.url, attributes: attributes)

		result.append(url)
		result.append(makeMarkdownCode("]]"))
		return result
	}

	public func visit(node: InlineCodeNode) -> NSMutableAttributedString {
		let result = makeMarkdownCode("`")
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.codeTextColor,
			.backgroundColor: Appearance.codeBlockBackgroundColor,
			.font: UIFont.monospacedDigitSystemFont(ofSize: Appearance.textSize, weight: .medium)
		]
		let text = NSMutableAttributedString(string: node.code, attributes: attributes)
		result.append(text)
		result.append(makeMarkdownCode("`"))
		return result
	}

	public func visit(node: CodeBlockNode) -> NSMutableAttributedString {
		let result = makeMarkdownCode(String(repeating: "`", count: node.level) + node.lang)
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.codeTextColor,
			.font: UIFont.monospacedDigitSystemFont(ofSize: Appearance.textSize, weight: .medium)
		]
		let text = NSMutableAttributedString(string: node.code, attributes: attributes)
		result.append(String.lineBreak)
		result.append(text)
		result.append(String.lineBreak)
		result.append(makeMarkdownCode(String(repeating: "`", count: node.level)))
		result.append(String.lineBreak)
		return result
	}

}

private extension RawAttributedTextVisitor {
	func makeMarkdownCode(_ code: String) -> NSMutableAttributedString {
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.markdownCodeColor,
			.font: UIFont.systemFont(ofSize:  Appearance.textSize)
		]

		return NSMutableAttributedString(string: code, attributes: attributes)
	}
}

