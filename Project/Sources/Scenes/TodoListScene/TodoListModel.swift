//
//  TodoListModelModels.swift
//  TodoList
//
//  Created by Kirill Leonov on 28.11.2023.
//  Copyright (c) 2023. All rights reserved.
//

import Foundation
import TaskManagerPackage

enum TodoListModel {

	enum Request {
		struct TaskSelected {
			let indexPath: IndexPath
		}
	}

	struct Response {
		/// Содержит в себе список заданий для отображения, разделенные на секции
		/// В данном случае Task представляет из себя бизнес-сущность, натой ответ нужен для того,
		/// чтобы связать полученные данные с секциями и подготовить их к отображению.
		let data: [SectionWithTasks]

		struct SectionWithTasks {
			let section: Section
			let tasks: [Task]
		}
	}

	struct ViewModel {

		/// Содержит в себе список заданий для отображения, разделенные на секции
		let tasksBySections: [Section]

		struct Section {
			let title: String
			let tasks: [Task]
		}

		/// Перечисление представляющее наши заданий для отображения на экране
		enum Task {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}

		/// Обычное задание, содержит только то, что отображается на экране
		struct RegularTask {
			let title: String
			let completed: Bool
		}

		/// Важное задание, содержит только то, что отображается на экране
		struct ImportantTask {
			let title: String
			let completed: Bool
			let deadLine: String
			let priority: String
		}
	}
}
