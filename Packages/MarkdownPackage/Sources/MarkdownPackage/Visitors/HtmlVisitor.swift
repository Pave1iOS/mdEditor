//
//  HtmlVisitor.swift
//  Markdown
//
//  Created by Kirill Leonov on 22.02.2024.
//

import Foundation

public final class HtmlVisitor: IVisitor {

	public func visit(node: Document) -> [String] {
		return visitChildren(of: node)
	}

	public func visit(node: HeaderNode) -> String {
		let text = visitChildren(of: node).joined()
		return "<h\(node.level)>\(text)</h\(node.level)>"
	}

	public func visit(node: ParagraphNode) -> String {
		let text = visitChildren(of: node).joined()
		return "<p>\(text)</p>"
	}

	public func visit(node: TextNode) -> String {
		return visitChildren(of: node).joined()
	}

	public func visit(node: BlockquoteNode) -> String {
		let text = visitChildren(of: node).joined()
		return "<blockquote><p>\(text)</p></blockquote>"
	}

	public func visit(node: PlainTextNode) -> String {
		node.text
	}

	public func visit(node: BoldTextNode) -> String {
		"<strong>\(node.text)</strong>"
	}

	public func visit(node: BoldItalicTextNode) -> String {
		"<strong><em>\(node.text)</em></strong>"
	}

	public func visit(node: ItalicTextNode) -> String {
		"<em>\(node.text)</em>"
	}

	public func visit(node: StrikeTextNode) -> String {
		"<strike>\(node.text)</strike>"
	}

	public func visit(node: HighlightedTextNode) -> String {
		"<mark>\(node.text)</mark>"
	}

	public func visit(node: EscapedCharNode) -> String {
		node.char
	}

	public func visit(node: LineBreakNode) -> String {
		"<br/>"
	}

	public func visit(node: ImageNode) -> String {
		"<img src=\"\(node.url)>\" />"
	}

	public func visit(node: HorizontalLineNode) -> String {
		"<hr>"
	}

	public func visit(node: OrderedListNode) -> String {
		var list = ["<ol>"]
		node.children.forEach {
			list.append("<li>\(visitChildren(of: $0).joined())</li>")
		}
		list.append("</ol>")

		return list.joined()
	}

	public func visit(node: UnorderedListNode) -> String {
		var list = ["<ul>"]
		node.children.forEach {
			list.append("<li>\(visitChildren(of: $0).joined())</li>")
		}
		list.append("</ul>")

		return list.joined()
	}

	public func visit(node: ExternalLinkNode) -> String {
		"<a href=\"\(node.url)>\">\(node.text)</a>"
	}

	public func visit(node: InternalLinkNode) -> String {
		"<a href=\"\(node.url)>\">\(node.url)</a>"
	}

	public func visit(node: InlineCodeNode) -> String {
		"<code>\(node.code)</code>"
	}

	public func visit(node: CodeBlockNode) -> String {
		"<code>\(node.code)</code>"
	}
}
