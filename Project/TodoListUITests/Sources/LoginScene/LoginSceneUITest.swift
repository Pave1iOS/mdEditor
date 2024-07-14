import XCTest

final class LoginSceneUITest: XCTestCase {
	let app = XCUIApplication()
	lazy var loginScreen = LoginScreenObject(app: app)

	override func setUp() {
		super.setUp()
		app.launch()
	}

	func test3_login_withValidCred_mustBeSuccess() {

		let todoListScreen = TodoListScreenObject(app: app)

		loginScreen
			.isLoginScreen()
			.set(login: TestsString.ValidLoginAndPassword.login)
			.set(password: TestsString.ValidLoginAndPassword.password)
			.login()

		todoListScreen
			.tapOn(cell: 1, inSection: 0)
	}

	func test_login_with_InvalidCred_mustBeSuccess() {
		loginScreen
			.isLoginScreen()
			.set(login: TestsString.InvalisLoginAndPassword.login)
			.set(password: TestsString.InvalisLoginAndPassword.password)
			.login()
			.checkAlertAndClose()
			.isLoginScreen()
	}
}
