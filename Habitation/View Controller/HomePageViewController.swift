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
        
        
//        login.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
//        login.layer.shadowColor = UIColor.lightGray.cgColor
//        login.layer.shadowOpacity = 0.5
//        login.layer.shadowRadius = 1
//        login.layer.masksToBounds = false
         
        editItems(borderColor: UIColor.systemGray.cgColor, borderWidth: 1, curveRadius: 26)
        
    }
    
    func editItems(borderColor: CGColor, borderWidth: CGFloat, curveRadius: CGFloat) {
        
        let itemsArray = [login, signUp]
        
        _ = itemsArray.map {
            
            $0!.layer.borderColor = borderColor
            $0!.layer.borderWidth = borderWidth
            $0!.layer.cornerRadius = curveRadius

        }
        
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
