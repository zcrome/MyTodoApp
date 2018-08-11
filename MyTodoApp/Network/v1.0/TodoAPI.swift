//
//  TodoAPI.swift
//  MyTodoApp
//
//  Created by Melanie on 8/6/18.
//  Copyright © 2018 Doapps. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class TodoAPI{
  
  static let baseURL = "http://localhost:3000/"
  static let myTodosURL = "api/ToDos"
  static let modifyMyTodoUrl = "api/ToDos/%@"
	
	static let todoTasksUrl = "api/ToDos/%@/tasks"
	static let myTasksUrl = "api/Tasks"
	
}
