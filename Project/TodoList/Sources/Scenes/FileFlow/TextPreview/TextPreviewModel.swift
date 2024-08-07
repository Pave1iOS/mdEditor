import Foundation

enum TextPreviewModel {
	
	struct Response {
		let fileUrl: URL
		let fileContent: String
	}
	
	struct ViewModel {
		let currentTitle: String
		let text: NSAttributedString
	}
}
