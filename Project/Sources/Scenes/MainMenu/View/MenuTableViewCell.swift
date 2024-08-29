//
//  MenuTableViewCell.swift
//  MdEditor
//
//  Created by Kirill Leonov on 15.02.2024.
//  Copyright © 2024 leonovka.SwiftBook. All rights reserved.
//

import UIKit

final class MenuTableViewCell: UITableViewCell {

	static let reusableIdentifier = "MenuTableViewCell"

	// MARK: - Private properties

	private lazy var imageViewItem = makeImageViewItem()
	private lazy var label = makeLabel()

	// MARK: - Initialization

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		layout()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public methods

	func configure(menuTitle: String, menuImage: UIImage) {
		imageViewItem.image = menuImage
		label.text = menuTitle
	}
}

// MARK: - UI setup

private extension MenuTableViewCell {

	func setupUI() {
		backgroundColor = Theme.backgroundColor
	}

	func makeImageViewItem() -> UIImageView {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}

	func makeLabel() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 16)
		label.textColor = Theme.mainColor
		return label
	}
}

// MARK: - Layout UI

private extension MenuTableViewCell {
	func layout() {
		addSubview(imageViewItem)
		addSubview(label)

		NSLayoutConstraint.activate([
			imageViewItem.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Padding.normal),
			imageViewItem.centerYAnchor.constraint(equalTo: centerYAnchor),
			imageViewItem.widthAnchor.constraint(equalToConstant: Sizes.M.icon),
			imageViewItem.heightAnchor.constraint(equalToConstant: Sizes.M.icon),

			label.leadingAnchor.constraint(equalTo: imageViewItem.trailingAnchor, constant: Sizes.Padding.normal),
			label.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}
}
