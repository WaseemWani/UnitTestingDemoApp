//
//  ViewController.swift
//  UnitTestinDemoApp
//
//  Created by Waseem Wani on 25/01/23.
//

import UIKit

class LoginViewController: UIViewController {

    var viewModel: LoginViewModel?
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var emailValidationErrorLabel: UILabel!
    @IBOutlet var pswdValidationErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = " "
        title = "Login"
        viewModel = LoginViewModel()
        loginButton.layer.cornerRadius = 12
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            pswdValidationErrorLabel.isHidden = false
            pswdValidationErrorLabel.text = "Please enter valid email and password"
            return
        }
        pswdValidationErrorLabel.isHidden = true
        
        let result = viewModel?.login(email: email, password: password)
        if let shoudlAllowLogin = result?.shouldAllowLogin, !shoudlAllowLogin {
            showErrorMessage(result: result)
        } else {
            pushTodoListViewController()
        }
    }
    
    private func showErrorMessage(result: LoginResponse?) {
        if let isValidEmail = viewModel?.isValidEmail, !isValidEmail {
            pswdValidationErrorLabel.isHidden = true
            emailValidationErrorLabel.isHidden = false
            emailValidationErrorLabel.text = result?.errorMessage
        } else if let isValidPswd = viewModel?.isValidPassword, !isValidPswd {
            emailValidationErrorLabel.isHidden = true
            pswdValidationErrorLabel.isHidden = false
            pswdValidationErrorLabel.text = result?.errorMessage
        }
    }
    
    func pushTodoListViewController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let todoListVC = storyboard.instantiateViewController(identifier: "TodoListViewController") as? TodoListViewController else {
            return
        }
        navigationController?.pushViewController(todoListVC, animated: true)
    }
}

