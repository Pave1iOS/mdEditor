//
//  AttributedTextVisitor.swift
//  Markdown
//
//  Created by Kirill Leonov on 22.02.2024.
//

import UIKit

public final class AttributedTextVisitor: IVisitor {
	private let width: CGFloat

	public init(width: CGFloat = .zero) {
		self.width = width
	}

	public func visit(node: Document) -> [NSMutableAttributedString] {
		visitChildren(of: node)
	}

	public func visit(node: HeaderNode) -> NSMutableAttributedString {
		let text = visitChildren(of: node).joined()

		let result = NSMutableAttributedString()
		result.append(text)
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.headerColor[node.level - 1],
			.font: UIFont.systemFont(ofSize: Appearance.headerSize[node.level - 1])
		]
		result.addAttributes(attributes, range: NSRange(0..<result.length))
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
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textColor,
			.font: UIFont.systemFont(ofSize: Appearance.textSize)
		]
		let code =  NSMutableAttributedString(
			string: String(repeating: ">", count: node.level) + " ",
			attributes: attributes
		)
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
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textBoldColor,
			.font: UIFont.boldSystemFont(ofSize:  Appearance.textSize)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)
		return text
	}

	public func visit(node: BoldItalicTextNode) -> NSMutableAttributedString {
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
		return text
	}

	public func visit(node: ItalicTextNode) -> NSMutableAttributedString {
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textItalicColor,
			.font: UIFont.italicSystemFont(ofSize: Appearance.textSize)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attributes)

		return text
	}

	public func visit(node: StrikeTextNode) -> NSMutableAttributedString {
		let attribute: [NSAttributedString.Key: Any] = [
			.strikethroughStyle : NSUnderlineStyle.single.rawValue,
			.foregroundColor: Appearance.textStrikeColor,
			.strikethroughColor: UIColor.red,
			.font: UIFont.systemFont(ofSize: Appearance.textSize)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attribute)

		return text
	}

	public func visit(node: HighlightedTextNode) -> NSMutableAttributedString {
		let attribute: [NSAttributedString.Key: Any] = [
			.backgroundColor: Appearance.highlightedTextBackground,
			.foregroundColor: Appearance.textHighlightedColor,
			.font: UIFont.systemFont(ofSize: Appearance.textSize)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attribute)

		return text
	}


	public func visit(node: EscapedCharNode) -> NSMutableAttributedString {
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textColor,
			.font: UIFont.systemFont(ofSize: Appearance.textSize)
		]

		let result = NSMutableAttributedString(string: node.char, attributes: attributes)
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
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.textColor,
			.font: UIFont.systemFont(ofSize: Appearance.textSize)
		]
		let fontWidth = ("_" as NSString).size(withAttributes: attributes).width
		let result = NSMutableAttributedString(
			string: String(repeating: "_", count: Int(width / fontWidth)),
			attributes: attributes
		)
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
			result.append(NSMutableAttributedString(string: String("\(index). "), attributes: attributes))
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
			result.append(NSMutableAttributedString(string: String("• "), attributes: attributes))
			result.append($0)
			result.append(String.lineBreak)
		}
		return result
	}

	public func visit(node: ExternalLinkNode) -> NSMutableAttributedString {
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.linkColor,
			.font: UIFont.boldSystemFont(ofSize:  Appearance.textSize),
			.underlineStyle: NSUnderlineStyle.single.rawValue
		]
		let result = NSMutableAttributedString(string: node.text, attributes: attributes)
		if let url = URL(string: node.url) {
			result.addAttribute(.link, value: url, range: NSRange(0..<result.length))
		}
		return result
	}

	public func visit(node: InternalLinkNode) -> NSMutableAttributedString {
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.linkColor,
			.font: UIFont.boldSystemFont(ofSize:  Appearance.textSize),
			.underlineStyle: NSUnderlineStyle.single.rawValue
		]
		let text = NSMutableAttributedString(string: node.url, attributes: attributes)
		return text
	}

	public func visit(node: InlineCodeNode) -> NSMutableAttributedString {
		let attributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.codeTextColor,
			.backgroundColor: Appearance.codeBlockBackgroundColor,
			.font: UIFont.monospacedDigitSystemFont(ofSize: Appearance.textSize, weight: .medium)
		]
		let text = NSMutableAttributedString(string: node.code, attributes: attributes)
		return text
	}

	public func visit(node: CodeBlockNode) -> NSMutableAttributedString {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .right

		let langAttributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.codeLangColor,
			.font: UIFont.italicSystemFont(ofSize: Appearance.codeLangSize),
			.paragraphStyle: paragraphStyle
		]
		let lang = NSMutableAttributedString(string: node.lang, attributes: langAttributes)

		let codeAttributes : [NSAttributedString.Key: Any] = [
			.foregroundColor: Appearance.codeTextColor,
			.font: UIFont.monospacedDigitSystemFont(ofSize: Appearance.codeTextSize, weight: .medium)
		]
		let code = NSMutableAttributedString(string: node.code, attributes: codeAttributes)

		let result = NSMutableAttributedString()
		result.append(lang)
		result.append(String.lineBreak)
		result.append(code)
		result.append(String.lineBreak)
		return result
	}
}
