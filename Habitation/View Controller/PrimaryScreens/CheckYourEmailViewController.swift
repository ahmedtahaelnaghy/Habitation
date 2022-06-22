//
//  CheckYourEmailViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/06/2022.
//

import UIKit

class CheckYourEmailViewController: UIViewController {
    
    @IBOutlet weak var loginBtnEditing: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        editItems(borderColor: UIColor.systemGray.cgColor, borderWidth: 1, curveRadius: 20)
        
    }
    
    func editItems(borderColor: CGColor, borderWidth: CGFloat, curveRadius: CGFloat) {
        
        let itemsArray = [loginBtnEditing]
        
        _ = itemsArray.map {
            
            $0!.layer.borderColor = borderColor
            $0!.layer.borderWidth = borderWidth
            $0!.layer.cornerRadius = curveRadius

        }
        
    }
    
    
    
    
    
    @IBAction func loginBtn(_ sender: Any) {
        
        
        
        
        
    }
    
    

}
