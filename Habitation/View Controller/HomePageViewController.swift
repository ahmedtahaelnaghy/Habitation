//
//  HomePageViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 13/03/2022.
//

import UIKit

class HomePageViewController: UIViewController {
    
    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var signUp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        login.layer.borderColor = UIColor.systemGray.cgColor
        login.layer.borderWidth = 1
        login.layer.cornerRadius = 25
        
        signUp.layer.borderColor = UIColor.systemGray.cgColor
        signUp.layer.borderWidth = 1
        signUp.layer.cornerRadius = 25
        
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController {
            
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
        
        
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpViewController {
            
            
            
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    
    
    
}
