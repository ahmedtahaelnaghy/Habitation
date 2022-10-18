//
//  SignUpViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 13/03/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyPasswordTextField: UITextField!
    @IBOutlet weak var signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let itemsArray = [emailTextField, nameTextField, passwordTextField, verifyPasswordTextField, signUp]
        self.hideKeyboardWhenTappedAround()
        editItemsShape(for: itemsArray as [Any], borderColor: .systemGray, borderWidth: 1, curveRadius: 20)
        addImageToTextField(textField: emailTextField, imageName: "email", imageViewFrameX: 15)
        addImageToTextField(textField: nameTextField, imageName: "profileName", imageViewFrameX: 15)
        addImageToTextField(textField: passwordTextField, imageName: "password", imageViewFrameX: 151)
        addImageToTextField(textField: verifyPasswordTextField, imageName: "password", imageViewFrameX: 15)
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        registerNewUser()
    }
}

extension SignUpViewController {
    
    func registerNewUser() {
        guard let name = nameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let verifyPassword = verifyPasswordTextField.text else { return }
        
        if email.isEmpty || name.isEmpty || password.isEmpty || verifyPassword.isEmpty {
            showAlert(message: "All fields are required")
        } else {
            AddNewUserAccountRequest(name: name, email: email, password: password, verifyPassword: verifyPassword)
        }
    }
    
    func AddNewUserAccountRequest(name: String, email: String, password: String, verifyPassword: String) {
        AuthServiceManager().addNewAcountInAlamofire(name: name, email: email, password: password, verifyPassword: verifyPassword) { [weak self] result in
            switch result {
            case .success(_):
                self?.goToTabBarScreen()
            case .failure(_):
                self?.showAlert(message: "Some thing wrong")
            }
        }
    }
    
    func goToTabBarScreen() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarC") as? TabBarViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
