//
//  Nodes.swift
//  MarkdownToHtml
//
//  Created by Kirill Leonov on 16.02.2024.
//

import Foundation

public protocol INode {
	var children: [INode] { get }
}

public class BaseNode: INode {
	private(set) public var children: [INode]

	public init(_ children: [INode] = []) {
		self.children = children
	}
}

public final class Document: BaseNode {
}

extension Document {
	func accept<T: IVisitor>(visitor: T) -> [T.Result] {
		visitor.visit(node: self)
	}
}

public final class HeaderNode: BaseNode {
	public let level: Int

	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

public final class BlockquoteNode: BaseNode {
	public let level: Int

	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

public final class ParagraphNode: BaseNode {
}

public final class TextNode: BaseNode {
}

public final class PlainTextNode: BaseNode {
	public let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class BoldTextNode: BaseNode {
	public let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class ItalicTextNode: BaseNode {
	public let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class BoldItalicTextNode: BaseNode {
	public let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class StrikeTextNode: BaseNode {
	public let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class HighlightedTextNode: BaseNode {
	public let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class EscapedCharNode: BaseNode {
	public let char: String

	public init(char: String) {
		self.char = char
	}
}

public final class InlineCodeNode: BaseNode {
	public let code: String

	public init(code: String) {
		self.code = code
	}
}

public final class CodeBlockNode: BaseNode {
	public let level: Int
	public let lang: String
	public let code: String

	public init(level: Int, lang: String, code: String) {
		self.level = level
		self.lang = lang
		self.code = code
	}
}

public final class ExternalLinkNode: BaseNode {
	public let url: String
	public let text: String

	public init(url: String, text: String) {
		self.url = url
		self.text = text
	}
}

public final class InternalLinkNode: BaseNode {
	public let url: String

	public init(url: String) {
		self.url = url
	}
}

public final class LineBreakNode: BaseNode {
	public init() { }
}

public final class HorizontalLineNode: BaseNode {
	public init() { }
}

public final class ImageNode: BaseNode {
	public let url: String
	public let size: String

	public init(url: String, size: String) {
		self.url = url
		self.size = size
	}
}

public final class TaskNode: BaseNode {
	public let isDone: Bool

	public init(isDone: Bool, children: [INode] = []) {
		self.isDone = isDone
		super.init(children)
	}
}

public final class OrderedListNode: BaseNode {
	public let level: Int

	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

public final class UnorderedListNode: BaseNode {
	public let level: Int

	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}
