//
//  DetailsViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 28/06/2022.
//

import UIKit
import CoreAudio
import MapKit
import CoreLocation

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var SingleHomeDetailsImage: UIImageView!
    @IBOutlet weak var allImagesCollectionView: UICollectionView!
    @IBOutlet weak var areaDetailsLbl: UILabel!
    @IBOutlet weak var numberOfRoomsDetailsLbl: UILabel!
    @IBOutlet weak var numberOfBathroomsDetailsLbl: UILabel!
    @IBOutlet weak var descriptionDetailsText: UILabel!
    @IBOutlet weak var directionDetailsLbl: UILabel!
    @IBOutlet weak var locationDetailsLbl: UILabel!
    @IBOutlet weak var priceDetailsLbl: UILabel!
    @IBOutlet weak var cashDiscountDetailsLbl: UILabel!
    @IBOutlet weak var callBtnShape: UIButton!
    @IBOutlet weak var favBtnShape: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var collectionView: UICollectionViewCell!
    var locationManager: CLLocationManager!
    var comingData: HomesComingData!
    var isFavorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        allImagesCollectionView.delegate = self
        allImagesCollectionView.dataSource = self
        setupHorizontalCollectionViewUI(for: allImagesCollectionView, groupWidth: 0.3)
        editItemsShape(for: [callBtnShape!], borderColor: .systemGray, borderWidth: 1, curveRadius: 24, shadowColor: .lightGray, shadowRadius: 1, shadowOffset: CGSize(width: 1.2, height: 1.2), shadowOpacity: 0.5, masksToBounds: true)
        showDetails()
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
//        mapView.showsUserLocation = true
        
    }
    
    @IBAction func favBtn(_ sender: Any) {
        changeFavBtnImage()
    }
    
    @IBAction func callPressed(_ sender: Any) {
        callNumber(phoneNumber: "01017820973")
    }
    
    private func callNumber(phoneNumber:String) {
      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comingData.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCell", for: indexPath) as! ImagesCollectionViewCell
        cell.homeImages.setImage(for: comingData.images[indexPath.row])
        
        editItemsShape(for: [cell], borderColor: .lightGray, borderWidth: 0.5, curveRadius: 15, shadowColor: .lightGray, shadowRadius: 1, shadowOffset: CGSize(width: 2, height: 1), shadowOpacity: 0.5, masksToBounds: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SingleHomeDetailsImage.setImage(for: comingData.images[indexPath.row])
    }
}

extension DetailsViewController {
    
    func changeFavBtnImage() {
        let setId = comingData.id
        collectionView.changeFavBtnImage(for: favBtnShape, flag: &isFavorite, itemId: 108, favId: setId)
        isFavorite.toggle()
    }
}

extension DetailsViewController {
    
    func showDetails() {
        
        SingleHomeDetailsImage.setImage(for: comingData.images[0])
        areaDetailsLbl.text = "\(comingData.area) sqrt"
        numberOfRoomsDetailsLbl.text = "\(comingData.bedRoomsNo) rooms"
        numberOfBathroomsDetailsLbl.text = "\(comingData.bathsNo) bathrooms"
        directionDetailsLbl.text = comingData.diriction
        priceDetailsLbl.text = "Rent: \(comingData.price) L.E"
        cashDiscountDetailsLbl.text = "Cash Discount \(comingData.cashDiscount)"
        descriptionDetailsText.text = "\(comingData.description)"
        
        switch comingData.isFav {
        case true:
            favBtnShape.imageView?.image = UIImage(named: "heart")
        case false:
            favBtnShape.imageView?.image = UIImage(named: "heart_like")
        }
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: comingData.location[0], longitude: comingData.location[1])
        annotation1.title = "\(comingData.name)"
        annotation1.subtitle = "\(comingData.type)"
        self.mapView.addAnnotation(annotation1)
        
    }
}

