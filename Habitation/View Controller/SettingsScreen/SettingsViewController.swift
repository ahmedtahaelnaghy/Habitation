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
    @IBOutlet weak var phoneNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItemsShape()
        setUserDetailsOnLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    @IBAction func userProfileBtn(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        logOut()
    }
}

extension SettingsViewController {
    
    func setupItemsShape() {
        let itemsArray = [userProfileView, logOutBtnShape]
        editItemsShape(for: itemsArray as [Any], borderColor: .lightGray, borderWidth: 1, curveRadius: 30, shadowColor: .lightGray, shadowRadius: 1, shadowOffset: CGSize(width: 1.2, height: 1.2), shadowOpacity: 0.5, masksToBounds: false)
    }
    
    func fetchData() {
        ProfileServiceManager().fetchProfileDataFromAlamofire { [weak self] result in
            switch result {
            case .success(let model):
                self?.setData(for: model)
            case .failure(_):
                self?.showAlert(message: "Something went wrong!")
            }
        }
    }
    
    func setData(for model: ProfileComingData) {
        guard let image = model.image else {return}
        phoneNumber.text = (model.userPhoneNumber == nil) || (model.userPhoneNumber == "") ? "Add Your Number" : model.userPhoneNumber
        userImg.setImage(for: image)
    }
    
    func setUserDetailsOnLabel() {
        let userDfaults = UserDefaults.standard
        userDetails.text = userDfaults.string(forKey: "name")
    }
    
    func logOut() {
        let userDefaults = UserDefaults.standard
        userDefaults.set("", forKey: "name")
        userDefaults.set("", forKey: "email")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "rootVC") as? HomePageViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
