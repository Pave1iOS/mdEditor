//
//  TaskScanner.swift
//  MdEditor
//
//  Created by Kirill Leonov on 24.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import Foundation
import MarkdownPackage
import TaskManagerPackage

final class TaskScanner: ITaskRepository {

	private let document: Document

	init(document: Document) {
		self.document = document
	}

	func getTasks() -> [Task] {
		scan(document: document)
	}
}

private extension TaskScanner {
	func scan(document: Document) -> [Task] {
		var result = [Task]()

		document.children.forEach { node in
			if let task = node as? TaskNode {
				result.append(taskNodeToRegularTask(task: task))
			}
		}

		return result
	}

	func taskNodeToRegularTask(task: TaskNode) -> RegularTask {
		let visitor = AttributedTextVisitor()
		let text = visitor.visitChildren(of: task)
		return RegularTask(title: text.joined().string, completed: task.isDone)
	}
}
