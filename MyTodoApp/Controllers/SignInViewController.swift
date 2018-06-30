//
//  SignInViewController.swift
//  MyTodoApp
//
//  Created by zcrome on 6/30/18.
//  Copyright © 2018 Doapps. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var signInButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
			titleLabel.text = "Bienvenido"
    }

	
	
	
	@IBAction func signInAction(_ sender: UIButton) {
		performSegue(withIdentifier: "goToHome", sender: nil)
	}
	
	
	

}
