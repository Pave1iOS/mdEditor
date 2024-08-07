import Foundation

final class TextPreviewAssembler {
	func assembly(file: File) -> TextPreviewViewController {
		let viewController = TextPreviewViewController()
		let presenter = TextPreviewPresenter(viewController: viewController)
		let interactor = TextPreviewInteractor(presenter: presenter, file: file)
		viewController.interactor = interactor
		return viewController
	}
}
