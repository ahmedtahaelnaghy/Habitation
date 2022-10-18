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
        let itemsArray = [loginBtnEditing]
        sendingToEmailLbl.text = comingEmail
        editItemsShape(for: itemsArray as [Any], borderColor: .systemGray, borderWidth: 1, curveRadius: 20)
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
            self.navigationController?.popToRootViewController(animated: true)
    }
}
