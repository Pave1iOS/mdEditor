import Foundation

enum LocalizationStrings {
	// MARK: - Login Scene
	static let authorization = "Authorization".localized
	static let loginButtonText = "LoginButton".localized
	static let passwordTFPlaceholder = "Password".localized
	static let loginTFPlaceholder = "LoginTextField".localized
	// MARK: - ToDo Scene
	static let todoListTitle = "TodoListTitle".localized
	// MARK: - Task
	static let completed = "Completed".localized
	static let uncompleted = "Uncompleted".localized
	static let all = "All".localized
	static let regular = "Regular".localized
	static let important = "Important".localized
	// MARK: - Task property
	static let deadline = "Deadline".localized
	// MARK: - MOCK data
	static let doHomeworkMOCK = "MOCK_doHomework".localized
	static let doWorkoutMOCK = "MOCK_doWorkout".localized
	static let writeNewTasksMOCK = "MOCK_writeNewTasks".localized
	static let solve3algorithmsMOCK = "MOCK_solve3algorithms".localized
	static let goShoppingMOCK = "MOCK_goShopping".localized
}

extension String {
	var localized: String {
		return NSLocalizedString(self, comment: "")
	}
}
