//
//  PdfPreviewAssembler.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation

final class PdfPreviewAssembler {
	func assembly(file: File) -> PdfPreviewViewController {
		let viewController = PdfPreviewViewController()

		let pdfAuthor = (Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String) ?? ""
		let presenter = PdfPreviewPresenter(viewController: viewController, pdfAuthor: pdfAuthor)
		let interactor = PdfPreviewInteractor(presenter: presenter, file: file)
		viewController.interactor = interactor
		return viewController
	}
}
