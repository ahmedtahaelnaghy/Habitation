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
        
        editItems(borderColor: UIColor.systemGray.cgColor, borderWidth: 1, curveRadius: 20)
        
        addImageToTextField(textField: emailTextField, image: UIImage(named: "email")!)
        addImageToTextField(textField: cityTextField, image: UIImage(named: "city")!)
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
        
    func editItems(borderColor: CGColor, borderWidth: CGFloat, curveRadius: CGFloat) {
        
        let itemsArray = [emailTextField, cityTextField, passwordTextField, verifyPasswordTextField, signUp]
        
        _ = itemsArray.map {
            
            $0!.layer.borderColor = borderColor
            $0!.layer.borderWidth = borderWidth
            $0!.layer.cornerRadius = curveRadius

        }
        
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
           
        
    }
    
}
