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
        
        navigationItem.hidesBackButton = true
        tabBarController?.tabBar.isHidden = true
        
        editItems()
        
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

// Code for buttons shape
extension HomePageViewController {
    
    func editItems() {
        
        let itemsArray = [login, signUp]
        
        _ = itemsArray.map {
            
            $0!.layer.borderColor = UIColor.systemGray.cgColor
            $0!.layer.borderWidth = 1
            $0!.layer.cornerRadius = 26
            $0!.layer.shadowColor = UIColor.lightGray.cgColor
            $0!.layer.shadowOpacity = 0.5
            $0!.layer.shadowRadius = 1
            $0!.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
            $0!.layer.masksToBounds = true

        }
    }
    
}
