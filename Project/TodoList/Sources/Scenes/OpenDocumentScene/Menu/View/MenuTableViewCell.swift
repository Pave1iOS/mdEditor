//
//  MenuTableViewCell.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 05.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import UIKit

final class MenuTableViewCell: UITableViewCell {
	static let reusableIdentifier = "MenuTableViewCell"
	
	private lazy var imageViewItem = makeImageViewItem()
	private lazy var label = makeLabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupUI()
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(menuTitle: String, menuImage: UIImage) {
		imageViewItem.image = menuImage
		label.text = menuTitle
	}
}

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

private extension MenuTableViewCell {
	func layout() {
		addSubview(imageViewItem)
		addSubview(label)
		
		NSLayoutConstraint.activate([
			imageViewItem.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Padding.normal),
			imageViewItem.centerYAnchor.constraint(equalTo: centerYAnchor),
			imageViewItem.widthAnchor.constraint(equalToConstant: Sizes.M.icon) ,
			imageViewItem.heightAnchor.constraint(equalToConstant: Sizes.M.icon),
			
			label.leadingAnchor.constraint(equalTo: imageViewItem.trailingAnchor, constant: -Sizes.Padding.normal),
			label.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}
}
