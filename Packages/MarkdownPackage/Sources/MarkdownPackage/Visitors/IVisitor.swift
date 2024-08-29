//
//  IVisitor.swift
//  Markdown
//
//  Created by Kirill Leonov on 22.02.2024.
//

import Foundation

public protocol IVisitor {
	associatedtype Result

	func visit( node: Document) -> [Result]
	func visit( node: HeaderNode) -> Result
	func visit( node: ParagraphNode) -> Result
	func visit( node: TextNode) -> Result
	func visit( node: BlockquoteNode) -> Result
	func visit( node: ExternalLinkNode) -> Result
	func visit( node: InternalLinkNode) -> Result
	func visit( node: PlainTextNode) -> Result
	func visit( node: BoldTextNode) -> Result
	func visit( node: BoldItalicTextNode) -> Result
	func visit( node: ItalicTextNode) -> Result
	func visit( node: StrikeTextNode) -> Result
	func visit( node: HighlightedTextNode) -> Result
	func visit( node: EscapedCharNode) -> Result
	func visit( node: LineBreakNode) -> Result
	func visit( node: HorizontalLineNode) -> Result
	func visit( node: ImageNode) -> Result
	func visit(node: OrderedListNode) -> Result
	func visit(node: UnorderedListNode) -> Result
	func visit( node: CodeBlockNode) -> Result
	func visit( node: InlineCodeNode) -> Result
}

public extension IVisitor {
	func visitChildren(of node: INode) -> [Result] {
		return node.children.compactMap { child in
			switch child {
			case let child as HeaderNode:
				return visit(node: child)
			case let child as ParagraphNode:
				return visit(node: child)
			case let child as TextNode:
				return visit(node: child)
			case let child as BlockquoteNode:
				return visit(node: child)
			case let child as ExternalLinkNode:
				return visit(node: child)
			case let child as InternalLinkNode:
				return visit(node: child)
			case let child as PlainTextNode:
				return visit(node: child)
			case let child as BoldTextNode:
				return visit(node: child)
			case let child as BoldItalicTextNode:
				return visit(node: child)
			case let child as ItalicTextNode:
				return visit(node: child)
			case let child as StrikeTextNode:
				return visit(node: child)
			case let child as HighlightedTextNode:
				return visit(node: child)
			case let child as EscapedCharNode:
				return visit(node: child)
			case let child as LineBreakNode:
				return visit(node: child)
			case let child as HorizontalLineNode:
				return visit(node: child)
			case let child as ImageNode:
				return visit(node: child)
			case let child as OrderedListNode:
				return visit(node: child)
			case let child as UnorderedListNode:
				return visit(node: child)
			case let child as InlineCodeNode:
				return visit(node: child)
			case let child as CodeBlockNode:
				return visit(node: child)
			default:
				return nil
			}
		}
	}
}
