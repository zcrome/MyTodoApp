//
//  TodoDetailViewController.swift
//  MyTodoApp
//
//  Created by zcrome on 7/21/18.
//  Copyright © 2018 Doapps. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

class TodoDetailViewController: UIViewController {
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var todoActionButton: UIButton!
  
  var todo: Todo?
  var isExisted = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let todo = todo {
      titleTextField.text = todo.title
      descriptionTextView.text = todo.description
    }
    if !isExisted {
      todoActionButton.setTitle("Create", for: .normal)
    }else{
      todoActionButton.setTitle("Save Changes", for: .normal)
      todoActionButton.addTarget(self, action: #selector(saveTodoChanges), for: .touchUpInside)
    }
  }
  
  @objc func saveTodoChanges() {
    if let todo = self.todo {
      todo.title = titleTextField.text!
      todo.description = descriptionTextView.text!
      saveTodoChangeWith(todo: todo)
      
    }
  }
  
  func saveTodoChangeWith(todo: Todo){

    TodoEndPoint.editTodo(withUpdatedTodo: todo) { (todoId, error) in
      if let error = error{
        print(error)
        return
      }
      if let _ = todoId{
        DispatchQueue.main.async {
          self.navigationController?.popViewController(animated: true)
        }
      }
    }
    
  }
  
}



