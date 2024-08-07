import Foundation
/// enum LaunchArguments для управления языками приложения при тестировании,
/// содержит аргументы:.
/// - appleLanguages: для переключения языка приложения
///
/// - enum Language: содержит перечисление всех языков приложения и имеет кейсы:
///	- ru - Русский язык
///	- en - Английский язык
enum LaunchArguments {
	/// Аргумент для переключения языка приложения
	static let appleLanguages = "-AppleLanguages"
	/// Содержит перечисление всех языков приложения
	enum Language: String {
		/// Русский язык
		case english = "en"
		/// Английский язык
		case russian = "ru"
	}
}
