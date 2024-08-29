//
//  MarkdownToPdfConverter.swift
//
//  Created by Kirill Leonov on 22.05.2023.
//

import Foundation
import PDFKit

public final class MarkdownToPdfConverter: IMarkdownConverter {

	private let markdownToDocument = MarkdownToDocument()
	private let pageSize: PageSize
	private let pdfAuthor: String
	private let pdfTitle: String
	private let backgroundColor: UIColor

	public init(pageSize: MarkdownToPdfConverter.PageSize, backgroundColor: UIColor, pdfAuthor: String, pdfTitle: String) {
		self.pageSize = pageSize
		self.pdfAuthor = pdfAuthor
		self.pdfTitle = pdfTitle
		self.backgroundColor = backgroundColor
	}
	
	public func convert(markdownText: String) -> Data {
		let document = markdownToDocument.convert(markdownText: markdownText)
		
		let visitor = AttributedTextVisitor(width: pageSize.pageRect.width - Const.textIndent )
		let lines = document.accept(visitor: visitor)
		
		let pdfMetaData  = [
			kCGPDFContextAuthor: pdfAuthor,
			kCGPDFContextTitle: pdfTitle
		]
		
		let format = UIGraphicsPDFRendererFormat()
		format.documentInfo = pdfMetaData as [String: Any]

		let graphicsRenderer = UIGraphicsPDFRenderer(bounds: pageSize.pageRect, format: format)

		let data = graphicsRenderer.pdfData { context in
			newPage(context)
			
			var cursor: CGFloat = Const.cursorIndent
			
			lines.forEach { line in
				cursor = addAttributedText(
					context: context,
					text: line,
					indent: Const.textIndent,
					cursor: cursor,
					pdfSize: pageSize.pageRect.size
				)
			}
		}
		return data
	}

	public enum PageSize {
		case a4
		case usLetter
		case screen

		var pageRect: CGRect {
			switch self {
			case .a4:
				return CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
			case .usLetter:
				return CGRect(x: 0, y: 0, width: 612, height: 792)
			case .screen:
				return UIScreen.main.bounds
			}
		}
	}
}

private extension MarkdownToPdfConverter {
	func addAttributedText(
		context: UIGraphicsPDFRendererContext,
		text: NSAttributedString,
		indent: CGFloat,
		cursor: CGFloat,
		pdfSize: CGSize
	) -> CGFloat {
		let pdfTextHeight = textHeight(text, withConstrainedWidth: pdfSize.width - 2 * indent)

		let rect = CGRect(x: indent, y: cursor, width: pdfSize.width - 2 * indent, height: pdfTextHeight)
		text.draw(in: rect)

		return checkContext(context: context, cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
	}

	func textHeight(_ text: NSAttributedString, withConstrainedWidth width: CGFloat) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

		return ceil(boundingBox.height)
	}

	func checkContext(context: UIGraphicsPDFRendererContext, cursor: CGFloat, pdfSize: CGSize) -> CGFloat {
		if cursor > pdfSize.height - Const.safePageArea {
			newPage(context)
			return Const.cursorIndent
		}
		return cursor
	}

	func newPage(_ context: UIGraphicsPDFRendererContext) {
		context.beginPage()
		context.cgContext.setFillColor(backgroundColor.cgColor)
		context.fill(pageSize.pageRect)
	}

	enum Const {
		/// Отступ курсора в начале листа.
		static let cursorIndent: CGFloat = 20
		/// Отступ текста от границы листа.
		static let textIndent: CGFloat = 20
		/// Безопасное значение для грубого вычисления конца страницы.
		static let safePageArea: CGFloat = 100
	}
}
