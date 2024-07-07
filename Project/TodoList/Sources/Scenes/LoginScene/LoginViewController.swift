//
//  LoginViewController.swift
//  mdEditor
//
//  Created by Лилия Андреева on 28.06.2024.
//

import UIKit

// Всегда старайтесь, чтобы view была описана полностью моделью ViewModel, это облегчает тестирование
// и обработку информации. По сути View должна быть настолько простой, что името только 1 метод для клиента
// `func render(viewModel: LoginModel.ViewModel)`
protocol ILoginViewController: AnyObject {
}

final class LoginViewController: UIViewController, ILoginViewController {

	// MARK: - Dependencies

	var interactor: ILoginInteractor?

	// MARK: - Private properties

	private lazy var textFieldLogin: UITextField = makeTextField()
	private lazy var textFieldPass: UITextField = makeTextField()
	private lazy var buttonLogin: UIButton = makeButtonLogin()

	private var constraints = [NSLayoutConstraint]()

	// MARK: - Initialization

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}

	// depricated with iOS 17
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		self.textFieldLogin.layer.borderColor = Theme.black.cgColor
		self.textFieldPass.layer.borderColor = Theme.black.cgColor
	}
}

// MARK: - Actions

private extension LoginViewController {
	@objc
	func login() {
		if let email = textFieldLogin.text, let password = textFieldPass.text {
			let request = LoginModel.Request(login: email, password: password)
			interactor?.login(request: request)
		}
	}
}

// MARK: - Setup UI

private extension LoginViewController {

	func makeTextField() -> UITextField {
		let textField = UITextField()

		textField.backgroundColor = Theme.backgroundColor
		textField.textColor = Theme.mainColor
		textField.layer.borderColor = Theme.black.cgColor
		textField.layer.borderWidth = Sizes.borderWidth
		textField.layer.cornerRadius = Sizes.cornerRadius
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Sizes.Padding.half, height: textField.frame.height))
		textField.leftViewMode = .always
		textField.font = UIFont.preferredFont(forTextStyle: .body)

		textField.adjustsFontForContentSizeCategory = true
		textField.translatesAutoresizingMaskIntoConstraints = false

		textField.translatesAutoresizingMaskIntoConstraints = false

		return textField
	}

	func makeButtonLogin() -> UIButton {
		let button = UIButton()

		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.baseBackgroundColor = Theme.accentColor
		button.configuration?.title = L10n.ButtonLogin.title
		button.addTarget(self, action: #selector(login), for: .touchUpInside)
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
		button.titleLabel?.adjustsFontForContentSizeCategory = true

		button.translatesAutoresizingMaskIntoConstraints = false

		return button
	}

	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		title = L10n.LoginViewController.title
		navigationController?.navigationBar.prefersLargeTitles = true

		// Кастомная конфигурация наших полей
		textFieldLogin.placeholder = L10n.TextFieldLogin.placeholder
		textFieldPass.placeholder = L10n.TextFieldPass.placeholder
		textFieldPass.isSecureTextEntry = true

		view.addSubview(textFieldLogin)
		view.addSubview(textFieldPass)
		view.addSubview(buttonLogin)

		changeBorderColorWithTextField()
	}

	// Смена цветов border у textField при смене темы
	func changeBorderColorWithTextField() {

		if #available(iOS 17.0, *) {
			registerForTraitChanges(
				[UITraitUserInterfaceStyle.self],
				handler: { (self: Self, _: UITraitCollection) in
				if self.traitCollection.userInterfaceStyle == .light {
					self.textFieldLogin.layer.borderColor = Theme.black.cgColor
					self.textFieldPass.layer.borderColor = Theme.black.cgColor
				} else {
					self.textFieldLogin.layer.borderColor = Theme.white.cgColor
					self.textFieldPass.layer.borderColor = Theme.white.cgColor
				}
			})
		}

	}
}

// MARK: - Layout UI

private extension LoginViewController {

	func layout() {
		NSLayoutConstraint.deactivate(constraints)

		let newConstraints = [
			textFieldLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			textFieldLogin.topAnchor.constraint(equalTo: view.topAnchor, constant: thirdOfTheScreen),
			textFieldLogin.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Sizes.L.widthMultiplier),
			textFieldLogin.heightAnchor.constraint(equalToConstant: Sizes.L.height),

			textFieldPass.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			textFieldPass.topAnchor.constraint(equalTo: textFieldLogin.bottomAnchor, constant: Sizes.Padding.normal),
			textFieldPass.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Sizes.L.widthMultiplier),
			textFieldPass.heightAnchor.constraint(equalToConstant: Sizes.L.height),

			buttonLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			buttonLogin.topAnchor.constraint(equalTo: textFieldPass.bottomAnchor, constant: Sizes.Padding.double),
			buttonLogin.widthAnchor.constraint(equalToConstant: Sizes.L.width),
			buttonLogin.heightAnchor.constraint(equalToConstant: Sizes.L.height)
		]

		NSLayoutConstraint.activate(newConstraints)

		constraints = newConstraints
	}

	var thirdOfTheScreen: Double {
		return view.bounds.size.height / 3.0
	}
}
