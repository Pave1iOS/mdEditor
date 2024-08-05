import Foundation

enum FileManagerModel {
	enum Request {
		case fileSelected(_ indexPath: IndexPath)
	}
	
	struct Response {
		let currentFile: File?
		let files: [File]
	}
	
	struct ViewModel {
		let currentFolderName: String
		let files: [FileModel]
		
		struct FileModel {
			let name: String
			let info: String
			let isFolder: Bool
		}
	}
}
