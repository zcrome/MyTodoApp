//
//  TodosViewController.swift
//  MyTodoApp
//
//  Created by zcrome on 7/7/18.
//  Copyright © 2018 Doapps. All rights reserved.
//

import UIKit

class TodosViewController: UIViewController {

	@IBOutlet weak var todoTableView: UITableView!
	
	var todos: [Todo] = [Todo(title: "Lista de Compras", description: "Ingredientes de la cena", isTasksAvailable: false, creation: Date())]
	
    override func viewDidLoad() {
        super.viewDidLoad()

			todoTableView.register(UINib(nibName: "TodosTableViewCell", bundle: nil), forCellReuseIdentifier: "todoCell")
			todoTableView.dataSource = self
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	

}


extension TodosViewController: UITableViewDataSource{
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return todos.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! TodosTableViewCell
		
		cell.titleLabel.text = todos[indexPath.row].title
		cell.descriptionLabel.text = todos[indexPath.row].description
		cell.creationLabel.text = "\(todos[indexPath.row].creation)"
		
		return cell
	}
	
}

