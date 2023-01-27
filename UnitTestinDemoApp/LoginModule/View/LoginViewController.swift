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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = " "
        title = "Login"
        viewModel = LoginViewModel()
        loginButton.layer.cornerRadius = 12
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
//        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
//            emailTextField.layer.borderColor = UIColor.red.cgColor
//            return }
//        let result = viewModel?.login(email: email, password: password)
//        debugPrint(result)
        pushTodoListViewController()
    }
    
    func pushTodoListViewController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let todoListVC = storyboard.instantiateViewController(identifier: "TodoListViewController") as? TodoListViewController else {
            return
        }
        navigationController?.pushViewController(todoListVC, animated: true)
    }
}

