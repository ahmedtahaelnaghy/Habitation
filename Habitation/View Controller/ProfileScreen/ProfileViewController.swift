//
//  ProfileViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 19/06/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var nameTextFieldShape: UITextField!
    @IBOutlet weak var cityTextFieldShape: UITextField!
    @IBOutlet weak var numberTextFieldShape: UITextField!
    @IBOutlet weak var emailTextFieldShape: UITextField!
    @IBOutlet weak var updateProfileBtnShape: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editImageShape(image: userImg)
        editBtnShape(button: updateProfileBtnShape)
        editItems()
        
    }
   
    func editImageShape(image: UIImageView) {
        
        image.layer.borderColor = UIColor.systemGray.cgColor
        image.layer.borderWidth = 1
        image.layer.cornerRadius = image.bounds.height / 2
        image.layer.masksToBounds = true
        
    }
    
    func editItems() {
        
        let itemsArray = [nameTextFieldShape, cityTextFieldShape, numberTextFieldShape, emailTextFieldShape]
        
        _ = itemsArray.map {
            
            $0!.layer.borderColor = UIColor.lightGray.cgColor
            $0!.layer.borderWidth = 1
            $0!.layer.cornerRadius = 26
            $0!.layer.shadowColor = UIColor.lightGray.cgColor
            $0!.layer.shadowOpacity = 0.5
            $0!.layer.shadowRadius = 1
            $0!.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
            $0!.layer.masksToBounds = true

        }
        
    }
    
    func editBtnShape(button: UIButton) {
        
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 1
        button.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
        button.layer.masksToBounds = true
        
        
        
    }
    
    
}
