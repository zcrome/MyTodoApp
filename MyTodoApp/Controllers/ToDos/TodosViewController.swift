//
//  TodosViewController.swift
//  MyTodoApp
//
//  Created by zcrome on 7/7/18.
//  Copyright © 2018 Doapps. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class TodosViewController: UIViewController {
  
  @IBOutlet weak var todoTableView: UITableView!
  
  var todos: [Todo] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    todoTableView.register(UINib(nibName: "TodosTableViewCell", bundle: nil), forCellReuseIdentifier: "todoCell")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getData()
  }
  
  func getData(){
    TodoEndPoint.getTodos { (todos, error) in
      guard error == nil, let todos = todos  else{
        print(error!)
        return
      }
      DispatchQueue.main.async {
        self.todos = todos
        self.todoTableView.reloadData()
      }
    }
  }
  
  override func performSegue(withIdentifier identifier: String, sender: Any?) {
    if identifier == "todoDetail", let todo = sender as? Todo {
      let todoDetailVC = storyboard?.instantiateViewController(withIdentifier: "todoDetailVC") as! TodoDetailViewController
      todoDetailVC.todo = todo
      todoDetailVC.isExisted = true
      self.navigationController?.pushViewController(todoDetailVC, animated: true)
    }
  }
  
}

extension TodosViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let todo = todos[indexPath.row]
    performSegue(withIdentifier: "todoDetail", sender: todo)
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
    return cell
  }
  
}
