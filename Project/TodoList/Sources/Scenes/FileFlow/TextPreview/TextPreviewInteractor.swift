import Foundation

protocol ITextPreviewInteractor {
	func fetchData()
}

final class TextPreviewInteractor: ITextPreviewInteractor {

	// MARK: - Public properties

	// MARK: - Dependencies

	private var presenter: ITextPreviewPresenter

	// MARK: - Private properties

	let file: File

	// MARK: - Initialization

	init(presenter: ITextPreviewPresenter, file: File) {
		self.presenter = presenter
		self.file = file
	}

	// MARK: - Public methods

	func fetchData() {
		let fileContent = String(data: file.contentOfFile() ?? Data(), encoding: .utf8) ?? ""
		let response = TextPreviewModel.Response(fileUrl: file.url, fileContent: fileContent)
		presenter.present(response: response)
	}
}
