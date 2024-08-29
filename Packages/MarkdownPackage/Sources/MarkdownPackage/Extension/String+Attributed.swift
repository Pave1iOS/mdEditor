//
//  String.swift
//
//  Created by Kirill Leonov on 22.02.2024.
//

import Foundation

extension String {
	var attributed: NSMutableAttributedString {
		NSMutableAttributedString(string: self)
	}

	static var lineBreak: NSMutableAttributedString {
		NSMutableAttributedString(string: "\n")
	}

	static var tab: NSMutableAttributedString {
		NSMutableAttributedString(string: "\t")
	}
}
