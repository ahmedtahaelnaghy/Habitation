//
//  LoginViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 13/03/2022.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var rememberMe: UIButton!
    
    var isActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let itemsArray = [emailTextField, passwordTextField, login]
        self.hideKeyboardWhenTappedAround()
        editItemsShape(for: itemsArray as [Any], borderColor: .systemGray, borderWidth: 1, curveRadius: 20)
        addImageToTextField(textField: emailTextField, imageName: "email", imageViewFrameX: 15)
        addImageToTextField(textField: passwordTextField, imageName: "password", imageViewFrameX: 15)
        
    }
    
    @IBAction func forgotPasswordBtn(_ sender: Any) {
        goToForgetPasswordScreen()
    }
    
    @IBAction func rememberMeBtn(_ sender: Any) {
        rememberMeBtnStatus()
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        registerOldUser()
    }
}

extension LoginViewController {
    
    // Change rememberMeBtn image when tapping in.
    func rememberMeBtnStatus() {
        switch isActive {
        case true:
            rememberMe.setImage(UIImage(named: "true"), for: .normal)
        case false:
            rememberMe.setImage(UIImage(named: "emptySquare"), for: .normal)
        }
        isActive.toggle()
    }
}

extension LoginViewController {
    
    // Check all textFields and if all things right the app will login.
    func registerOldUser() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        if email.isEmpty || password.isEmpty {
            showAlert(message: "All fields are required")
        } else {
            loginRequestChecking(email: email, password: password)
        }
    }
    
    // Login user if have an account in application and if have not an account or add wrong info the alert will shown.
    func loginRequestChecking(email: String, password: String) {
        AuthServiceManager().fetchAuthDataFromAlamofire(email: email, password: password) { [weak self] result in
            switch result {
            case .success(_):
                self?.checkUserToken()
            case .failure(_):
                self?.showAlert(message: "Your email or password is wrong")
            }
        }
    }
    
    // Check the user token to show his data when login.
    func checkUserToken() {
        AuthServiceManager().tokenData { [weak self] result in
            switch result {
            case .success(_):
                self?.goToNextScreen()
            case .failure(_):
                self?.showAlert(message: "Your email or password is wrong")
            }
        }
    }
    
    // push to next screen when all info right.
    func goToNextScreen() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarC") as? TabBarViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // push to forget password screen.
    func goToForgetPasswordScreen() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as? ForgotPasswordViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
