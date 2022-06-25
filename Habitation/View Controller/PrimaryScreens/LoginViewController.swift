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
        
        editItems(borderColor: UIColor.systemGray.cgColor, borderWidth: 1, curveRadius: 20)
        addImageToTextField(textField: emailTextField, image: UIImage(named: "email")!)
        addImageToTextField(textField: passwordTextField, image: UIImage(named: "password")!)
        
    }
    
    @IBAction func forgotPasswordBtn(_ sender: Any) {
       
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as? ForgotPasswordViewController {
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func rememberMeBtn(_ sender: Any) {
        
        rememberMeBtnStatus()
        
    }
    
    func rememberMeBtnStatus() {
        
        if isActive {
                rememberMe.setImage(UIImage(named: "emptySquare"), for: .normal)
        }
        else {
            rememberMe.setImage(UIImage(named: "true"), for: .normal)
        }
        
        isActive.toggle()
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        oldUserRegister()
        
    }
    
    func oldUserRegister() {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        if email.isEmpty || password.isEmpty {
            
            showAlert(message: "All fields are required")
            
        }
        else {
            
            AuthServiceManager().fetchAuthDataFromAlamofire(email: email, password: password) { result in
                
                switch result {
                    
                case .success(_):
                    
                    AuthServiceManager().tokenData { result in
                        switch result {
                            
                        case .success(_):
                            
                            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarC") as? TabBarViewController {
                                
                                self.navigationController?.pushViewController(vc, animated: true)
                                
                            }
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                case .failure(_):
                    
                    self.showAlert(message: "Your email or password is wrong")
                    
                }
                
            }
            
        }
        
    }
     
}

// Code for textFields and buttons shape
extension LoginViewController {
    
    func editItems(borderColor: CGColor, borderWidth: CGFloat, curveRadius: CGFloat) {
        
        let itemsArray = [emailTextField, passwordTextField, login]
        
        _ = itemsArray.map {
            
            $0!.layer.borderColor = borderColor
            $0!.layer.borderWidth = borderWidth
            $0!.layer.cornerRadius = curveRadius

        }
        
    }
    
    // Method to add image in text field
    func addImageToTextField(textField: UITextField, image: UIImage) {
        
        let imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: image.size.width, height: image.size.height))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: image.size.height))

        imageView.image = image

        view.addSubview(imageView)

        textField.leftView = view
                                
        textField.leftViewMode = .always
        
    }
    
}

// Showing Alert functions
extension LoginViewController {
    
    func showAlert(message: String) {
        
        let alertController = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)

        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
}
