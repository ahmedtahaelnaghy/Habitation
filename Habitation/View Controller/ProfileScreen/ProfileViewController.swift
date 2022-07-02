//
//  ProfileViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 19/06/2022.
//

import UIKit
import Photos
import BSImagePicker
import SDWebImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var updateProfileBtnShape: UIButton!
    
    var delegate: AddUserImg?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationItem.hidesBackButton = true
        
        editImageShape(image: userImg)
        editBtnShape(button: updateProfileBtnShape)
        editItems()
        setDataInFields()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        ProfileServiceManager().fetchProfileDataFromAlamofire { [self] result in
            
            switch result {
                
                
                
            case .success(let model):
                cityTextField.text = model.city
                numberTextField.text = model.userPhoneNumber
                
                guard let image = model.image else {return}
                
                userImg.sd_setImage(with: URL(string: "\(image)"), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
        
        
    }
    
    func setDataInFields() {
        
        let userDefaults = UserDefaults.standard
        nameTextField.text = userDefaults.string(forKey: "name")
        emailTextField.text = userDefaults.string(forKey: "email")
        
    }
    
    @IBAction func openGalleryBtn(_ sender: Any) {
        getImgFromGallery()
    }
    
    @IBAction func updateProfileBtn(_ sender: Any) {
        editProfile()
    }
    
    func editProfile() {
        
        guard let city = cityTextField.text else {return}
        guard let phoneNumber = numberTextField.text else {return}
            
        ProfileServiceManager().editProfileFromAlamofire(city: city, phoneNumber: phoneNumber, image: [userImg.image!.converUIImgaeToData(withQuality: 0.7)!]) { result in

            switch result {

            case .success(_):
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
       
}

// Openning gallery and select user image
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func getImgFromGallery() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let galleryImage = info[.originalImage] as? UIImage {

            userImg.image = galleryImage

            print(galleryImage)
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}


// Code for textFields and image shape
extension ProfileViewController {
    
    func editImageShape(image: UIImageView) {
        
        image.layer.borderColor = UIColor.systemGray.cgColor
        image.layer.borderWidth = 1
        image.layer.cornerRadius = image.bounds.height / 2
        image.layer.masksToBounds = true
        
    }
    
    func editItems() {
        
        let itemsArray = [nameTextField, cityTextField, numberTextField, emailTextField]
        
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
        
        _ = itemsArray.map {
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))

            $0!.leftView = view
            $0!.leftViewMode = .always
                
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
