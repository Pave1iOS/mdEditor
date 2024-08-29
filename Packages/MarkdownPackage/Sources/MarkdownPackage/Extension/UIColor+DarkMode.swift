//
//  File.swift
//  
//
//  Created by Kirill Leonov on 22.03.2024.
//

import UIKit

extension UIColor {
	static func color(light: UIColor, dark: UIColor) -> UIColor {
		if #available(iOS 13, *) {
			return .init { traitCollection in
				return traitCollection.userInterfaceStyle == .dark ? dark : light
			}
		} else {
			return light
		}
	}
}
