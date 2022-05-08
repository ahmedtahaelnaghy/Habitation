//
//  SettingsViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/03/2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var UserDetailsView: UIView!
    
    @IBOutlet weak var RentedPropertiesView: UIView!
    
    @IBOutlet weak var MyCardsView: UIView!
    
    @IBOutlet weak var DarkModeView: UIView!
    
    @IBOutlet weak var LogOutView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        editItems()
        
        
        
    }
    
    func editItems() {
        
        let itemsArray = [UserDetailsView, RentedPropertiesView, MyCardsView, DarkModeView, LogOutView]
        
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
