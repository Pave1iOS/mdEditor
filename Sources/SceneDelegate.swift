//
//  SceneDelegate.swift

import UIKit
import TaskManagerPackage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

//	private var taskManager = TaskManager()
	private var orderedTaskManager: OrderedTaskManager! // swiftlint:disable:this implicitly_unwrapped_optional
	private var appCoordinator: ICoordinator! // swiftlint:disable:this implicitly_unwrapped_optional

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)

		let navigationController = UINavigationController()

		let repository = TaskRepositoryStub()
		orderedTaskManager = OrderedTaskManager(taskManager: TaskManager())
		orderedTaskManager.addTasks(tasks: repository.getTasks())

		appCoordinator = AppCoordinator(
			navigationController: navigationController,
			taskManager: orderedTaskManager
		)

		window.rootViewController = navigationController
		window.makeKeyAndVisible()

		if let urlContext = connectionOptions.urlContexts.first {
			handleDeeplink(url: urlContext.url)
		} else {
			appCoordinator.start()
		}

		self.window = window
	}

	func handleDeeplink(url: URL) {
	}
}
