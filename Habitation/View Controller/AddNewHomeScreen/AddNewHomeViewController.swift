//
//  AddNewHomeViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/06/2022.
//

import UIKit
import PhotosUI

class AddNewHomeViewController: UIViewController, PHPickerViewControllerDelegate {
    
    @IBOutlet weak var unitNameTextField: UITextView!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var unitPriceTextField: UITextView!
    @IBOutlet weak var cashPercentageDiscountTextField: UITextView!
    @IBOutlet weak var typeTextField: UITextView!
    @IBOutlet weak var areaTextField: UITextView!
    @IBOutlet weak var numberOfBathroomsTextField: UITextView!
    @IBOutlet weak var numberOfBedroomsTextField: UITextView!
    @IBOutlet weak var locationTextField: UITextView!
    @IBOutlet weak var saveBtnShape: UIButton!
    @IBOutlet weak var cancelBtnShape: UIButton!
    @IBOutlet weak var openGalleryShape: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        
        editItems()
        textFieldShape()
    
    }
    
    @IBAction func openGalleryBtn(_ sender: Any) {
        getImagesFromGallery()
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        guard let unitName = unitNameTextField.text else {return}
        guard let description = descriptionTextField.text else {return}
        guard let unitPrice = Double(unitPriceTextField.text) else {return}
        guard let cashPercentageDiscount = Double(cashPercentageDiscountTextField.text) else {return}
        guard let type = typeTextField.text else {return}
        guard let area = Int(areaTextField.text) else {return}
        guard let numberOfBathrooms = Int(numberOfBathroomsTextField.text) else {return}
        guard let numberOfBedrooms = Int(numberOfBedroomsTextField.text) else {return}
        guard let location = Double(locationTextField.text) else {return}
        
        let avaiable: Bool = true
        let direction: String = "North"
        let images = UIImage().convertImageToPngString(image: UIImage(named: "logo")!)
        let img = [images, images]
        
        ComingHomeDataServiceManager().homeData(unitName: unitName, description: description, unitPrice: unitPrice, cashPercentageDiscount: cashPercentageDiscount, type: type, area: area, location: [location], numberOfBathrooms: numberOfBathrooms, numberOfBedrooms: numberOfBedrooms, images: img, available: avaiable, direction: direction) { result in
            
            switch result {
            
            case .success(_):
                print("Sucess")
            case .failure(_):
                print("Fail")
            }
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}


extension AddNewHomeViewController {
    
    func getImagesFromGallery() {
        
        var config = PHPickerConfiguration()
        
        config.selectionLimit = 10
        
        let phPickerVC = PHPickerViewController(configuration: config)
        
        phPickerVC.delegate = self
        
        present(phPickerVC, animated: true, completion: nil)
        
    }
    
    
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        for result in results {
            
            result.itemProvider.loadObject(ofClass: UIImage.self) { obj, error in
                
                if let image = obj as? UIImage {
                    
                    DispatchQueue.main.async {
                        
//                        self.newFriendImage.image = image
                        
                    }
                    
                }
  
            }
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
}



extension AddNewHomeViewController {
    
    func editItems() {
        
        let itemsArray = [saveBtnShape, cancelBtnShape, openGalleryShape]
        
        _ = itemsArray.map {
            
            $0!.layer.borderColor = UIColor.systemGray.cgColor
            $0!.layer.borderWidth = 1
            $0!.layer.cornerRadius = 23
            $0!.layer.shadowColor = UIColor.lightGray.cgColor
            $0!.layer.shadowOpacity = 0.5
            $0!.layer.shadowRadius = 1
            $0!.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
            $0!.layer.masksToBounds = true

        }
    }
    
    func textFieldShape() {
        
        let textFieldsArray = [unitNameTextField, descriptionTextField, unitPriceTextField, cashPercentageDiscountTextField, typeTextField, areaTextField, numberOfBathroomsTextField, numberOfBedroomsTextField, locationTextField]

        _ = textFieldsArray.map {
            
            $0!.layer.borderColor = UIColor.lightGray.cgColor
            $0!.layer.borderWidth = 1
            
        }
        
    }
    
}
