//
//  ProfileViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 19/06/2022.
//

import UIKit
import Photos
import BSImagePicker

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
        hideKeyboardWhenTappedAround()
        setupItemsDesign()
        setDataInFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchProfileData()
    }
    
    @IBAction func openGalleryBtn(_ sender: Any) {
        getImgFromGallery()
    }
    
    @IBAction func updateProfileBtn(_ sender: Any) {
        editProfile()
    }
}

extension ProfileViewController {
    
    func setupItemsDesign() {
        let itemsArray = [nameTextField, cityTextField, numberTextField, emailTextField]
        makeLeftSpaceForTF(for: itemsArray)
        
        editItemsShape(for: itemsArray as [Any], borderColor: .lightGray, borderWidth: 1, curveRadius: 26, shadowColor: .lightGray, shadowRadius: 1, shadowOffset: CGSize(width: 1.2, height: 1.2), shadowOpacity: 0.5, masksToBounds: true)
        
        editItemsShape(for: [updateProfileBtnShape as Any], borderColor: .lightGray, borderWidth: 1, curveRadius: 20, shadowColor: .lightGray, shadowRadius: 1, shadowOffset: CGSize(width: 1.2, height: 1.2), shadowOpacity: 0.25, masksToBounds: true)
        
        editItemsShape(for: [userImg as Any], borderColor: .systemGray, borderWidth: 1, curveRadius: (userImg.bounds.height / 2), masksToBounds: true)
    }
    
    func editProfile() {
        guard let city = cityTextField.text else { return }
        guard let phoneNumber = numberTextField.text else { return }
        
        ProfileServiceManager().editProfileFromAlamofire(city: city, phoneNumber: phoneNumber, image: [userImg.image!.converUIImgaeToData(withQuality: 0.7)!]) { [weak self] result in
            switch result {
            case .success(_):
                self?.navigationController?.popViewController(animated: true)
            case .failure(_):
                self?.showAlert(message: "Something wrong")
            }
        }
    }
    
    func fetchProfileData() {
        ProfileServiceManager().fetchProfileDataFromAlamofire { [weak self] result in
            switch result {
            case .success(let model):
                self?.setData(for: model)
            case .failure(_):
                self?.showAlert(message: "Something wrong")
            }
        }
    }
    
    func setData(for model: ProfileComingData) {
        guard let image = model.image else {return}
        cityTextField.text = model.city
        numberTextField.text = model.userPhoneNumber
        userImg.setImage(for: image)
    }
    
    func setDataInFields() {
        let userDefaults = UserDefaults.standard
        nameTextField.text = userDefaults.string(forKey: "name")
        emailTextField.text = userDefaults.string(forKey: "email")
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
        }
        dismiss(animated: true, completion: nil)
    }
}
