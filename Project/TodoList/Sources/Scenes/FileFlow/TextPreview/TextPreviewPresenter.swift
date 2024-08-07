import Foundation

protocol ITextPreviewPresenter {
	func present(response: TextPreviewModel.Response)
}

final class TextPreviewPresenter: ITextPreviewPresenter {
	
	// MARK: - Dependencies
	
	private weak var viewController: ITextPreviewViewController?
	
	// MARK: - Initialization
	
	init(viewController: ITextPreviewViewController?) {
		self.viewController = viewController
	}
	
	// MARK: - Public methods
	
	func present(response: TextPreviewModel.Response) {
		
		
		let viewModel = TextPreviewModel.ViewModel(
			currentTitle: response.fileUrl.lastPathComponent,
			text: response.fileContent
		)
		viewController?.render(viewModel: viewModel)
	}
}
