//
//  ForgotPasswordViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 13/03/2022.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var getNewPassword: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editItems(borderColor: UIColor.systemGray.cgColor, borderWidth: 1, curveRadius: 20)
        addImageToTextField(textField: emailTextField, image: UIImage(named: "email")!)
        
    }
    
    @IBAction func getNewPasswordBtn(_ sender: Any) {
        
        getPasswordProcess()
        
    }
    
    func getPasswordProcess() {
        
        guard let email = emailTextField.text else {return}
                
        if email.isEmpty {

            showAlert()

        }
        else {
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "CheckVC") as? CheckYourEmailViewController {
                
                vc.comingEmail = "We've sent an email to \(email) . Click the link in the email to reset your password."
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }
        
    }
    
    func showAlert() {
        
        let alertController = UIAlertController(title: "Alert!", message: "All fields are required", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)

        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
}

// Code for textFields and buttons shape
extension ForgotPasswordViewController {
    
    func editItems(borderColor: CGColor, borderWidth: CGFloat, curveRadius: CGFloat) {
        
        let itemsArray = [emailTextField, getNewPassword]
        
        _ = itemsArray.map {
            
            
            $0!.layer.borderColor = borderColor
            $0!.layer.borderWidth = borderWidth
            $0!.layer.cornerRadius = curveRadius
            
        }
                
    }
    
    func addImageToTextField(textField: UITextField, image: UIImage) {
        
        let imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: image.size.width, height: image.size.height))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: image.size.height))
        
        view.addSubview(imageView)
        imageView.image = image
        
        textField.leftView = view
        textField.leftViewMode = .always
        
    }
    
}
