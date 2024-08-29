//
//  Sequence+Joined.swift
//
//  Created by Kirill Leonov on 22.02.2024.
//

import Foundation

public extension Sequence where Iterator.Element == NSMutableAttributedString {
	func joined() -> NSMutableAttributedString {
		reduce(into: NSMutableAttributedString()) { $0.append($1) }
	}
}
