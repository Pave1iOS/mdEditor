//
//  String+RegularExpression.swift
//
//  Created by Kirill Leonov on 16.02.2024.
//

import Foundation

extension String {
	func groups(for regexPattern: String) -> [[String]] {
		let text = self as NSString
		let range = NSMakeRange(.zero, text.length)
		let regex = try? NSRegularExpression(pattern: regexPattern, options: [])

		let result = regex?.matches(in: self, options: [], range: range).map { match in
			(1..<match.numberOfRanges).compactMap {
				match.range(at: $0).location == NSNotFound ? nil : text.substring(with: match.range(at: $0))
			}
		} ?? []

		return result
	}
	
	func group(for regexPattern: String) -> String? {
		do {
			let text = self
			let regex = try NSRegularExpression(pattern: regexPattern)
			let range = NSRange(location: .zero, length: text.utf16.count)

			if let match = regex.firstMatch(in: text, options: [], range: range),
			   let group = Range(match.range(at: 1), in: text) {
				return String(text[group])
			}
		} catch let error {
			print("invalid regex: \(error.localizedDescription)")
		}
		return nil
	}
}
