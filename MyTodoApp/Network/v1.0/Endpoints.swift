//
//  Endpoints.swift
//  MyTodoApp
//
//  Created by Melanie on 8/6/18.
//  Copyright © 2018 Doapps. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Endpoints{
  
  static func getTodos(completionHandler: @escaping(_ todos: [Todo]?, _ error: String?)->Void){
    Alamofire.request("\(TodoAPI.baseURL)\(TodoAPI.myTodosURL)").responseJSON { response in
      switch(response.result){
      case .success:
        let data = JSON(response.data!)
        completionHandler(Todo.from(jsonArray: data.array!),nil)
      case .failure(let error):
        print(error)
        completionHandler(nil,error.localizedDescription)
      }
    }
  }
  
  
  
  
}
