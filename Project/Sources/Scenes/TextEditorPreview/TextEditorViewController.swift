//
//  TextEditorViewController.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import UIKit

protocol ITextEditorViewController: AnyObject {
	func render(viewModel: TextEditorModel.ViewModel)
}

/// TextEditorViewController
final class TextEditorViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: ITextEditorInteractor?

	// MARK: - Private properties

	private var hasTasks = false

	private lazy var segmentControl = makeSegmentControl()

	private lazy var textViewEditor = makeTextView(
		accessibilityIdentifier: AccessibilityIdentifier.TextEditorScene.textViewEditor.description
	)

	private lazy var textViewPreview = makeTextView(
		accessibilityIdentifier: AccessibilityIdentifier.TextEditorScene.textViewPreview.description
	)

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
		interactor?.fetchData()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}
}

private extension TextEditorViewController {
	@objc func segmentChanged(_ sender: UISegmentedControl) {
		switchState(toShowPreview: sender.selectedSegmentIndex == 1)
	}

	func switchState(toShowPreview: Bool) {
		if toShowPreview {
			interactor?.needConvertText(text: textViewEditor.text)
			textViewEditor.isHidden = true
			textViewPreview.isHidden = false
		} else {
			textViewEditor.isHidden = false
			textViewPreview.isHidden = true
		}
	}
}

// MARK: - Actions

private extension TextEditorViewController {
	@objc
	func menuTapped() {
		let alert = UIAlertController(title: Consts.menuTitle, message: Consts.menuMessage, preferredStyle: .actionSheet)

		if hasTasks {
			alert.addAction(
				UIAlertAction(title: Consts.menuItemTasks, style: .default) { _ in
					self.interactor?.openTodoList(text: self.textViewEditor.text)
				}
			)
		}

		alert.addAction(
			UIAlertAction(title: Consts.menuItemPrint, style: .default) { _ in
				self.interactor?.print(text: self.textViewEditor.text)
			}
		)

		alert.addAction(UIAlertAction(title: Consts.menuItemDismiss, style: .cancel, handler: nil))

		self.present(alert, animated: true)
	}
}

// MARK: - Setup UI

private extension TextEditorViewController {
	func setupUI() {
		view.backgroundColor = Theme.backgroundColor

		textViewEditor.isHidden = false
		textViewPreview.isHidden = true
		textViewPreview.isEditable = false

		navigationController?.navigationBar.prefersLargeTitles = false

		view.addSubview(segmentControl)
		view.addSubview(textViewEditor)
		view.addSubview(textViewPreview)

		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .action,
			target: self,
			action: #selector(menuTapped)
		)
	}

	func makeTextView(accessibilityIdentifier: String) -> UITextView {
		let textView = UITextView()
		textView.font = UIFont.systemFont(ofSize: 18)
		textView.textColor = Theme.mainColor
		textView.backgroundColor = Theme.editorColor
		textView.textAlignment = .left
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.accessibilityIdentifier = accessibilityIdentifier
		return textView
	}

	func makeButton(imageSystemName: String, accessibilityIdentifier: String) -> UIButton {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: imageSystemName), for: .normal)
		button.accessibilityIdentifier = accessibilityIdentifier
		return button
	}

	func makeToolBar() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}

	func makeSegmentControl() -> UISegmentedControl {
		let segmentControl = UISegmentedControl(items: [Consts.segmentItemText, Consts.segmentItemConverter])
		segmentControl.translatesAutoresizingMaskIntoConstraints = false
		segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
		segmentControl.selectedSegmentIndex = 0
		return segmentControl
	}
}

// MARK: - Layout UI

private extension TextEditorViewController {

	func layout() {
		NSLayoutConstraint.deactivate(constraints)

		let newConstraints = [
			segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Sizes.Padding.small),
			segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),

			textViewEditor.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: Sizes.Padding.small),
			textViewEditor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
			textViewEditor.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal),
			textViewEditor.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor,
				constant: Sizes.Padding.normal
			),

			textViewPreview.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: Sizes.Padding.small),
			textViewPreview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
			textViewPreview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal),
			textViewPreview.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor,
				constant: Sizes.Padding.normal
			)
		]

		NSLayoutConstraint.activate(newConstraints)

		constraints = newConstraints
	}
}

// MARK: - ITextEditorViewController

extension TextEditorViewController: ITextEditorViewController {
	func render(viewModel: TextEditorModel.ViewModel) {
		switch viewModel {
		case .initial(let text, let title, let hasTasks):
			self.title = title
			textViewEditor.isScrollEnabled = false
			textViewEditor.text = text
			textViewEditor.isScrollEnabled = true
			self.hasTasks = hasTasks
		case .convert(let text, let hasTasks):
			textViewPreview.isScrollEnabled = false
			textViewPreview.attributedText = text
			textViewPreview.isScrollEnabled = true
			self.hasTasks = hasTasks
		case .print(let text):
			let printController = UIPrintInteractionController.shared
			printController.printingItem = text
			printController.present(animated: true)
		}
	}
}

private extension TextEditorViewController {
	enum Consts {
		static let segmentItemText = L10n.Editor.segmentItemText
		static let segmentItemConverter = L10n.Editor.segmentItemConverter
		static let menuTitle = "Меню"
		static let menuMessage = "Выберите дополнительное действие"
		static let menuItemTasks = "Посмотреть задачи"
		static let menuItemPrint = "Печать"
		static let menuItemDismiss = "Отмена"
	}
}
