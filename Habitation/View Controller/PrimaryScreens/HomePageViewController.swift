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
        let itemsArray = [login, signUp]
        navigationItem.hidesBackButton = true
        tabBarController?.tabBar.isHidden = true
        editItemsShape(for: itemsArray as [Any], borderColor: .systemGray, borderWidth: 1, curveRadius: 26)
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
