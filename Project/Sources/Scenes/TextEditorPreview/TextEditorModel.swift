//
//  TextEditorModel.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation

enum TextEditorModel {

	enum Response {
		case initial(fileUrl: URL, fileContent: String)
		case convert(text: String)
		case print(text: String)
	}

	enum ViewModel {
		case initial(text: String, title: String, hasTasks: Bool)
		case convert(text: NSMutableAttributedString, hasTasks: Bool)
		case print(data: Data)
	}
}
