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
import CoreLocation

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
    @IBOutlet weak var mapView: MKMapView!
    
    var imagesArray: [String] = []
    var selectedImages: [UIImage] = []
    let requestAPI = AddNewUnitRequest()
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        let itemsArray = [saveBtnShape, cancelBtnShape, openGalleryShape]
        let textFieldsArray = [unitNameTextField, descriptionTextField, unitPriceTextField, cashPercentageDiscountTextField, typeTextField, areaTextField, numberOfBathroomsTextField, numberOfBedroomsTextField, directionTextField, mapView]
        navigationItem.hidesBackButton = true
        hideKeyboardWhenTappedAround()
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationOnMap()
        editItemsShape(for: itemsArray as [Any], borderColor: .systemGray, borderWidth: 1, curveRadius: 23, shadowColor: .lightGray, shadowRadius: 1, shadowOffset: CGSize(width: 1.2, height: 1.2), shadowOpacity: 0.5, masksToBounds: true)
        editItemsShape(for: textFieldsArray as [Any], borderColor: .lightGray, borderWidth: 1, curveRadius: 0)
    }
    
    func locationOnMap() {
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 31.04215, longitude: 31.35944)
        annotation1.title = "Current Location"
        annotation1.subtitle = ""
        self.mapView.addAnnotation(annotation1)
        
    }
    
    @IBAction func openGalleryBtn(_ sender: Any) {
        uploadPhotosFromLibraryButtonPressed()
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        requestAPI.addNewUnit(model: AddNewItem(viewModel: getAddItemFromData())) { result in
            
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
        let location = [31.05879, 31.38347]
        
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
