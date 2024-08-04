//
//  OpenDocumentView.swift
//  MdEditor
//
//  Created by Pavel Gribachev on 01.08.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import UIKit

final class OpenDocumentViewController: UITableViewController {
	
	private let fileManager = FileExplorer()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .red
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	}
}

extension OpenDocumentViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		4
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		var content = cell.defaultContentConfiguration()

		let data = fileManager.getData(fromName: "file1", ext: .md)
		
		content.text = "Cells"
		content.secondaryText = fileManager.getText(fromData: data)
		cell.contentConfiguration = content

		return cell
	}
}

extension OpenDocumentViewController {
	
}
