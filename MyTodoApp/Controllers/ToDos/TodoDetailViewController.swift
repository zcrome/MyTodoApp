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
	
	@IBOutlet weak var taskTextField: UITextField!
	@IBOutlet weak var allowTasksSwitch: UISwitch!
	@IBOutlet weak var addNewTaskButton: UIButton!
	@IBOutlet weak var tasksTableView: UITableView!
	
	@IBOutlet weak var scrollView: UIScrollView!
	
  var todo: Todo?
  var isExisted = false
	var tasks: [Task] = []
	let numberToolbar = UIToolbar()
	
  override func viewDidLoad() {
    super.viewDidLoad()
		
    if let todo = todo {
      titleTextField.text = todo.title
      descriptionTextView.text = todo.description
			
			TodoEndPoint.getTaksFrom(Todo: todo, completionHandler: { (tasks, error) in
				if let error = error{
					print(error)
				}
				if let tasks = tasks, tasks.count > 0{
					DispatchQueue.main.async {
						self.tasks = tasks
						self.tasksTableView.reloadData()
						self.allowTasksSwitch.setOn(true, animated: true)
						self.allowTasksAction(self.allowTasksSwitch)
					}
				}
			})
			
    }
    if !isExisted {
      todoActionButton.setTitle("Create", for: .normal)
			todoActionButton.addTarget(self, action: #selector(createTodoDo), for: .touchUpInside)
    }else{
      todoActionButton.setTitle("Save Changes", for: .normal)
      todoActionButton.addTarget(self, action: #selector(saveTodoChanges), for: .touchUpInside)
    }
		
		numberToolbar.barStyle = .default
		numberToolbar.items = [
			UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
			UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
			UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(closeKeyboard))
		]
		numberToolbar.sizeToFit()
		taskTextField.inputAccessoryView = numberToolbar
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
  }
	
	@objc func closeKeyboard(){
		taskTextField.resignFirstResponder()
	}
	
	deinit{
		NotificationCenter.default.removeObserver(self)
	}
	
	@objc func keyboardWillShow(notification: NSNotification){
		adjustInsetForKeyboardShow(show: true, notification: notification)
	}
	
	@objc func keyboardWillHide(notification: NSNotification){
		adjustInsetForKeyboardShow(show: false, notification: notification)
	}
	
	func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification){
		
		let userInfo = notification.userInfo ?? [:]
		let keyboardFrameHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
		let adjustHeight = (keyboardFrameHeight * (show ? 1 : -1)) + 25
		
		scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: adjustHeight, right: 0)
	}
	
  
  @objc func saveTodoChanges() {
    if let todo = self.todo {
      todo.title = titleTextField.text!
      todo.description = descriptionTextView.text!
      saveTodoChangeWith(todo: todo)
      
    }
  }
	
	@objc func createTodoDo(){
		todoActionButton.isEnabled = false
		let newTodo = Todo(title: titleTextField.text!, description: descriptionTextView.text!, isTaskAvailable: false, creation: Date(), id: 0)
		TodoEndPoint.createTodo(withTodo: newTodo) { (idNewTodo, error) in
			if let error = error{
				print(error)
			}
			if let _ = idNewTodo{
				DispatchQueue.main.async {
					self.navigationController?.popViewController(animated: true)
				}
			}else{
				print("Error al crear")
			}
		}
	}
	
  
  func saveTodoChangeWith(todo: Todo){
		todoActionButton.isEnabled = false
    TodoEndPoint.editTodo(withUpdatedTodo: todo) { (todoId, error) in
			DispatchQueue.main.async {
				self.todoActionButton.isEnabled = true
			}
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
	
	
	@IBAction func allowTasksAction(_ sender: UISwitch) {
		if sender.isOn{
			taskTextField.isHidden = false
			addNewTaskButton.isHidden = false
			tasksTableView.isHidden = false
		}else{
			taskTextField.isHidden = true
			addNewTaskButton.isHidden = true
			tasksTableView.isHidden = true
		}
	}
	
	
	@IBAction func addNewTaskAction(_ sender: UIButton) {
		guard !taskTextField.text!.isEmpty  else {
			return
		}
		guard let todo = self.todo else{
			return
		}
		sender.isEnabled = false
		tasks.append(Task(title: taskTextField.text!, id: todo.id))
		tasksTableView.reloadData()
		TodoEndPoint.createTask(Title: taskTextField.text!, fromTodo: todo) { (idTask, error) in
			sender.isEnabled = true
			if let error = error{
				print(error)
			}
			if let idTask = idTask{
				DispatchQueue.main.async {
					print("TASK with ID \(idTask) created")
					self.taskTextField.text = ""
					self.taskTextField.resignFirstResponder()
				}
			}
		}
	}
}

extension TodoDetailViewController: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tasks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
		
		cell.textLabel?.text = tasks[indexPath.row].title
		
		return cell
	}
	
	
}

