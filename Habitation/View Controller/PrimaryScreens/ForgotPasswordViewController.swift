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
        let itemsArray = [emailTextField, getNewPassword]
        self.hideKeyboardWhenTappedAround()
        editItemsShape(for: itemsArray as [Any], borderColor: .systemGray, borderWidth: 1, curveRadius: 20)
        addImageToTextField(textField: emailTextField, imageName: "email", imageViewFrameX: 15)
    }
    
    @IBAction func getNewPasswordBtn(_ sender: Any) {
        getPasswordProcess()
    }
    
}

extension ForgotPasswordViewController {
    
    // Check email textField is empty to show alert or have the account.
    func getPasswordProcess() {
        guard let email = emailTextField.text else {return}
        
        if email.isEmpty {
            showAlert(message: "All fields are required")
        }
        else {
            goToCheckYouEmailScreen(for: email)
        }
    }
    
    // push to Check Your Email screen and add text to label.
    func goToCheckYouEmailScreen(for email: String) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CheckVC") as? CheckYourEmailViewController {
            vc.comingEmail = "We've sent an email to \(email) . Click the link in the email to reset your password."
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
