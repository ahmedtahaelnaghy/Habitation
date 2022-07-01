//
//  AddNewHomeViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/06/2022.
//

import UIKit
import Photos
import BSImagePicker
import MapKit

class AddNewHomeViewController: UIViewController, UIImagePickerControllerDelegate  {
    
    @IBOutlet weak var unitNameTextField: UITextView!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var unitPriceTextField: UITextView!
    @IBOutlet weak var cashPercentageDiscountTextField: UITextView!
    @IBOutlet weak var typeTextField: UITextView!
    @IBOutlet weak var areaTextField: UITextView!
    @IBOutlet weak var numberOfBathroomsTextField: UITextView!
    @IBOutlet weak var numberOfBedroomsTextField: UITextView!
    @IBOutlet weak var directionTextField: UITextView!
    @IBOutlet weak var saveBtnShape: UIButton!
    @IBOutlet weak var cancelBtnShape: UIButton!
    @IBOutlet weak var openGalleryShape: UIButton!
    @IBOutlet weak var map: MKMapView!
    
    var imagesArray: [String] = []
    var selectedImages: [UIImage] = []
    let requestAPI = AddNewUnitRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        editItems()
        textFieldShape()
    }
    
    @IBAction func openGalleryBtn(_ sender: Any) {
        uploadPhotosFromLibraryButtonPressed()
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        requestAPI.addNewUnit(model: AddNewItem(viewModel: getAddItemFromData())) { result in
            print(result)
            switch result {
                
            case.success(_):
                self.showAlert(message: "Sucess") { _ in
                    self.navigationController?.popViewController(animated: true)
                }

            case.failure(let error):
                print(error.localizedDescription)
            }
        }
          
    }
    
    func getAddItemFromData() -> AddNewItemViewModelProtocol{

        let avaiable: Bool = true
        let location = [31.0549, 31.3802]
        
        return AddNewItemViewModel(
                                name: unitNameTextField.text ?? "",
                                description: descriptionTextField.text ?? "",
                                price: Double(unitPriceTextField.text) ?? 0.0,
                                cashDiscount: Double(cashPercentageDiscountTextField.text) ?? 0.0,
                                type: typeTextField.text ?? "",
                                area: Int(areaTextField.text) ?? 0,
                                bathsNo: Int(numberOfBathroomsTextField.text) ?? 0,
                                bedRoomsNo: Int(numberOfBedroomsTextField.text) ?? 0,
                                location: location,
                                images: selectedImages,
                                available: avaiable,
                                diriction: directionTextField.text ?? ""
                                )
        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension AddNewHomeViewController {
    
    func uploadPhotosFromLibraryButtonPressed(){
        
        let imagePicker = ImagePickerController()
        
        presentImagePicker(imagePicker, select: nil, deselect: nil, cancel: nil) { assets in
            assets.forEach({self.selectedImages.append($0.uiImage)})
            print(self.selectedImages)
        }
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
        
        let textFieldsArray = [unitNameTextField, descriptionTextField, unitPriceTextField, cashPercentageDiscountTextField, typeTextField, areaTextField, numberOfBathroomsTextField, numberOfBedroomsTextField, directionTextField, map]

        _ = textFieldsArray.map {
            
            $0!.layer.borderColor = UIColor.lightGray.cgColor
            $0!.layer.borderWidth = 1
        }
    }
}
