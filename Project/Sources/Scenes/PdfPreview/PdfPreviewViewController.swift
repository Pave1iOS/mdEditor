//
//  PdfPreviewViewController.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import UIKit
import PDFKit

protocol IPdfPreviewViewController: AnyObject {
	func render(viewModel: PdfPreviewModel.ViewModel)
}

/// PdfPreviewViewController
final class PdfPreviewViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: IPdfPreviewInteractor?

	// MARK: - Private properties

	private var viewModel: PdfPreviewModel.ViewModel!
	private let pdfView = PDFView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
	private var constraints = [NSLayoutConstraint]()

	// MARK: - Initialization

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		interactor?.fetchData()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}

	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		interactor?.fetchData()
	}
}

// MARK: - Setup UI

private extension PdfPreviewViewController {
	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		navigationController?.navigationBar.prefersLargeTitles = false

		view.addSubview(pdfView)
		pdfView.translatesAutoresizingMaskIntoConstraints = false
		pdfView.backgroundColor = Theme.backgroundColor
	}
}

// MARK: - Layout UI

private extension PdfPreviewViewController {
	func layout() {
		NSLayoutConstraint.deactivate(constraints)

		let newConstraints = [
			pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		]

		NSLayoutConstraint.activate(newConstraints)

		constraints = newConstraints
	}
}

// MARK: - IPdfPreviewViewController

extension PdfPreviewViewController: IPdfPreviewViewController {
	func render(viewModel: PdfPreviewModel.ViewModel) {
		self.viewModel = viewModel
		title = viewModel.currentTitle
		pdfView.document = PDFDocument(data: viewModel.data)
	}
}
