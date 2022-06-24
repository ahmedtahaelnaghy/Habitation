//
//  CheckYourEmailViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/06/2022.
//

import UIKit

class CheckYourEmailViewController: UIViewController {
    
    @IBOutlet weak var loginBtnEditing: UIButton!
    @IBOutlet weak var sendingToEmailLbl: UILabel!
    
    var comingEmail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendingToEmailLbl.text = comingEmail
        editItems(borderColor: UIColor.systemGray.cgColor, borderWidth: 1, curveRadius: 20)
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
                                
            self.navigationController?.popToRootViewController(animated: true)
        
    }

}

// Code for button shape
extension CheckYourEmailViewController {
    
    func editItems(borderColor: CGColor, borderWidth: CGFloat, curveRadius: CGFloat) {
        
        let itemsArray = [loginBtnEditing]
        
        _ = itemsArray.map {
            
            $0!.layer.borderColor = borderColor
            $0!.layer.borderWidth = borderWidth
            $0!.layer.cornerRadius = curveRadius

        }
        
    }
    
}
