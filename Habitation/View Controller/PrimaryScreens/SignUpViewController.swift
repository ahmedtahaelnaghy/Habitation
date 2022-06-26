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
        
        
        editItems(borderColor: UIColor.systemGray.cgColor, borderWidth: 1, curveRadius: 20)
        addImageToTextField(textField: emailTextField, image: UIImage(named: "email")!)
        addImageToTextField(textField: nameTextField, image: UIImage(named: "profileName")!)
        addImageToTextField(textField: passwordTextField, image: UIImage(named: "password")!)
        addImageToTextField(textField: verifyPasswordTextField, image: UIImage(named: "password")!)
       
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        newUserRegister()
        
    }
    
    func newUserRegister() {
        
        guard let name = nameTextField.text else {return}
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let verifyPassword = verifyPasswordTextField.text else {return}
        
        if email.isEmpty || name.isEmpty || password.isEmpty || verifyPassword.isEmpty {
            
            showAlert(message: "All fields are required")
             
        }
        else {
                        
            AuthServiceManager().addNewAcountInAlamofire(name: name, email: email, password: password, verifyPassword: verifyPassword) { result in
                switch result {
                        
                case .success(_):
                    
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarC") as? TabBarViewController {

                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                    
                case .failure(_):
                    
                    self.showAlert(message: "Some thing wrong")
                    
                }
                
            }
            
        }
        
    }
    
    
}

// Code for textFields and buttons shape
extension SignUpViewController {
    
    func addImageToTextField(textField: UITextField, image: UIImage) {
        
        let imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: image.size.width, height: image.size.height))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: image.size.height))
        
        view.addSubview(imageView)
        imageView.image = image
        
        textField.leftView = view
        textField.leftViewMode = .always
        
    }
        
    func editItems(borderColor: CGColor, borderWidth: CGFloat, curveRadius: CGFloat) {
        
        let itemsArray = [emailTextField, nameTextField, passwordTextField, verifyPasswordTextField, signUp]
        
        _ = itemsArray.map {
            
            $0!.layer.borderColor = borderColor
            $0!.layer.borderWidth = borderWidth
            $0!.layer.cornerRadius = curveRadius

        }
        
    }
    
}

extension SignUpViewController {
    
    func showAlert(message: String) {
        
        let alertController = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)

        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
}
