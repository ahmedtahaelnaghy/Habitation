//
//  SignUpViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 13/03/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var verifyPasswordTextField: UITextField!
    
    @IBOutlet weak var signUp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editItems(curveRadius: 1, borderColor: UIColor.systemGray.cgColor, borderWidth: 20)
        
        addImageToTextField(textField: emailTextField, image: UIImage(named: "email")!)
        addImageToTextField(textField: cityTextField, image: UIImage(named: "cityTwo")!)
        addImageToTextField(textField: passwordTextField, image: UIImage(named: "password")!)
        addImageToTextField(textField: verifyPasswordTextField, image: UIImage(named: "password")!)
        
        
    }
    
    
    func addImageToTextField(textField: UITextField, image: UIImage) {
        
        let imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: image.size.width, height: image.size.height))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: image.size.height))
        
        view.addSubview(imageView)
        
        imageView.image = image
        
        textField.leftView = view
        
        textField.leftViewMode = .always
        
    }
    
    
    func editItems(curveRadius: CGFloat, borderColor: CGColor, borderWidth: CGFloat) {
        
        
        emailTextField.layer.borderWidth = curveRadius
        emailTextField.layer.borderColor = borderColor
        emailTextField.layer.cornerRadius = borderWidth
        
        
        cityTextField.layer.borderWidth = curveRadius
        cityTextField.layer.borderColor = borderColor
        cityTextField.layer.cornerRadius = borderWidth
        
        
        passwordTextField.layer.borderWidth = curveRadius
        passwordTextField.layer.borderColor = borderColor
        passwordTextField.layer.cornerRadius = borderWidth
        
        
        verifyPasswordTextField.layer.borderWidth = curveRadius
        verifyPasswordTextField.layer.borderColor = borderColor
        verifyPasswordTextField.layer.cornerRadius = borderWidth
        
        
        signUp.layer.borderWidth = curveRadius
        signUp.layer.borderColor = borderColor
        signUp.layer.cornerRadius = borderWidth
        
        
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        
        
        
        
    }
      
    
}
