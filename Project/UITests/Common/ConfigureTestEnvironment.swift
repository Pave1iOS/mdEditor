//
//  ConfigureTestEnvironment.swift


import Foundation

enum ConfigureTestEnvironment {

	static let lang = ["-AppleLanguages", "(en)"]
	static let skipLogin = ["-skipLogin"]

	enum ValidCredentials {
		static let login = "Admin"
		static let password = "pa$$32!"
	}

	enum InvalidCredentials {
		static let login = "pa$$32!"
		static let password = "Admin"
	}
}
