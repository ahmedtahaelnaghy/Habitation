//
//  SettingsViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/03/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var userProfileView: UIView!
    @IBOutlet weak var logOutBtnShape: UIButton!
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var userDetails: UILabel!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editItems()
        
        setUserDetailsOnLabel()
        
        
    }
        
    func setUserDetailsOnLabel() {
        
        let userDfaults = UserDefaults.standard
        userDetails.text = userDfaults.string(forKey: "name")
        
    }
    
    @IBAction func userProfileBtn(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileViewController {
            
            self.navigationController?.pushViewController(vc, animated: true)
        
        
        }
        
    }
    
    
    
    
    
    @IBAction func logOutBtn(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set("", forKey: "name")
        userDefaults.set("", forKey: "email")
        
        print(userDefaults.set("", forKey: "name"))
        print(userDefaults.set("", forKey: "email"))
        
        
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "rootVC") as? HomePageViewController {
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    


}

// Code for view and button shape
extension SettingsViewController {
    
    func editItems() {
        
        let itemsArray = [userProfileView, logOutBtnShape]

        _ = itemsArray.map {

            $0!.layer.borderColor = UIColor.lightGray.cgColor
            $0!.layer.borderWidth = 1
            $0!.layer.cornerRadius = 30
            $0!.layer.shadowColor = UIColor.lightGray.cgColor
            $0!.layer.shadowOpacity = 0.5
            $0!.layer.shadowRadius = 1
            $0!.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
            $0!.layer.masksToBounds = false

        }
    }
    
}
