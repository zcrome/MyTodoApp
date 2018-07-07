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
	@IBOutlet weak var signupButton: UIButton!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
			titleLabel.text = "Bienvenido"
    }

	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		usernameTextField.resignFirstResponder()
		passwordTextField.resignFirstResponder()
	}
	
	
	
	
	@IBAction func signInAction(_ sender: UIButton) {
		performSegue(withIdentifier: "goToHome", sender: nil)
		
	}
	
	
	
	@IBAction func signUpAction(_ sender: Any) {
	}
	
	

}
