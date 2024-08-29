//
//  File.swift
//  
//
//  Created by Kirill Leonov on 23.03.2024.
//

import UIKit

enum Appearance {
	static let markdownCodeColor: UIColor = .systemBrown

	static let textSize: CGFloat = 18
	static let textColor: UIColor = darkColor

	static let linkColor: UIColor = .systemBlue
	static let textBoldColor: UIColor = darkColor
	static let textBoldItalicColor: UIColor = darkColor
	static let textItalicColor: UIColor = darkColor
	static let textStrikeColor: UIColor = .systemRed
	static let textHighlightedColor: UIColor = .darkGray
	static let highlightedTextBackground: UIColor = .systemYellow

	static let headerSize: [CGFloat] = [40, 30, 26, 22, 20, 18]
	static let headerColor: [UIColor] = [
		darkColor,
		darkColor,
		darkColor,
		darkColor,
		darkColor,
		darkColor
	]

	static let codeTextSize: CGFloat = 18
	static let codeLangSize: CGFloat = 16
	static let codeBlockBackgroundColor: UIColor = .systemGray4
	static let codeLangColor: UIColor = darkColor
	static let codeTextColor: UIColor = .systemGray

	static let darkColor = UIColor.color(
		light: UIColor(red: 25 / 255, green: 25 / 255, blue: 25 / 255, alpha: 1),
		dark: UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
	)
}
