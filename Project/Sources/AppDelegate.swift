//
//  AppDelegate.swift
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		if #available(iOS 15.0, *) {
			let navigationBarAppearance = UINavigationBarAppearance()
			navigationBarAppearance.configureWithTransparentBackground()
			UINavigationBar.appearance().standardAppearance = navigationBarAppearance
			UINavigationBar.appearance().compactAppearance = navigationBarAppearance
			UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
		}

		return true
	}
	
	// MARK: UISceneSession Lifecycle
	func application(
		_ application: UIApplication,
		configurationForConnecting connectingSceneSession: UISceneSession,
		options: UIScene.ConnectionOptions
	) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}
}
