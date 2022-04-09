//
//  LoginViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 13/03/2022.
//

import UIKit

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
    
    
    @IBAction func forgotPasswordBtn(_ sender: Any) {
       
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as? ForgotPasswordViewController {
            
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    @IBAction func rememberMeBtn(_ sender: Any) {
        
        if isActive {
            
                rememberMe.setImage(UIImage(named: "emptySquare"), for: .normal)
            
        } else {
            
            rememberMe.setImage(UIImage(named: "true"), for: .normal)
            
        }
        
        isActive.toggle()
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        
        
        
        
    }
    
    
}
