//
//  TextEditorModel.swift
//  MdEditor
//
//  Created by Kirill Leonov on 16.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation

enum PdfPreviewModel {

	struct Response {
		let fileUrl: URL
		let fileContent: String
	}

	struct ViewModel {
		let currentTitle: String
		let data: Data
	}
}
