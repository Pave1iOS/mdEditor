//
//  NSRegularExpression+Match.swift
//  
//
//  Created by Kirill Leonov on 24.02.2024.
//

import Foundation

extension NSRegularExpression {
	func match(_ text: String) -> Bool {
		let range = NSRange(text.startIndex..., in: text)
		return firstMatch(in: text, range: range) != nil
	}
}
