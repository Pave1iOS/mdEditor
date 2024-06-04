//
//  CreateTaskModel.swift
//  TodoList
//
//  Created by Kirill Leonov on 05.12.2023.
//

import Foundation

enum CreateTaskModel {

	// Тут мы упрощаем запрос для того, чтобы UI мог собрать введенныю пользователем информацию
	// и отправить на обработку в интерактор. UI не подозревает, как именно сопоставляется
	// приоритет для ImportantTask и не должен про это умать, так как иначе бизнес-логика
	// будет протекать в UI.
	enum Request {
		case regular(String)
		case important(ImportantTask)

		struct ImportantTask {
			let title: String
			let priority: Int
		}
	}
}
