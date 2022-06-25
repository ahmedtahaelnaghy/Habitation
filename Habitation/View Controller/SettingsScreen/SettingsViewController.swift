//
//  SettingsViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/03/2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var UserDetailsView: UIView!
    
    @IBOutlet weak var logOutBtnShape: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editItems()
                
             
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set("", forKey: "name")
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "rootVC") as? HomePageViewController {
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    


}

extension SettingsViewController {
    
    func editItems() {
        
        let itemsArray = [UserDetailsView, logOutBtnShape]

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
