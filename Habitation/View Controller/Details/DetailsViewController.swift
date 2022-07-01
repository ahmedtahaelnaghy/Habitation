//
//  DetailsViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 28/06/2022.
//

import UIKit
import SDWebImage
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
    
    var locationManager: CLLocationManager!
    var comingData: HomesComingData!
    var isFavorite: Bool = false
//    var comingFavData: FavoriteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allImagesCollectionView.delegate = self
        allImagesCollectionView.dataSource = self
        
        setupUiForAllImagesCollectionView()
        editButtonsShape(button: callBtnShape)
        showDetails()
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
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
        
        cell.homeImages.sd_setImage(with: URL(string: "http://13.93.33.202:8000\(comingData.images[indexPath.row])"), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
        
        editCollectionViewShape(collectionView: cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SingleHomeDetailsImage.sd_setImage(with: URL(string: "http://13.93.33.202:8000\(comingData.images[indexPath.row])"), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
        
    }
    
}

// Collection View design
extension DetailsViewController {
    
    func setupUiForAllImagesCollectionView() {

        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)), subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous

        let layout = UICollectionViewCompositionalLayout(section: section)

        allImagesCollectionView?.collectionViewLayout = layout

    }
    
}

// Collection View and Button shape
extension DetailsViewController {
    
    func editCollectionViewShape(collectionView: UICollectionViewCell) {
        
        collectionView.layer.cornerRadius = 15
        collectionView.layer.borderWidth = 0.5
        collectionView.layer.borderColor = UIColor.lightGray.cgColor
        collectionView.layer.shadowOffset = CGSize(width: 2, height: 1)
        collectionView.layer.shadowColor = UIColor.lightGray.cgColor
        collectionView.layer.shadowOpacity = 0.5
        collectionView.layer.shadowRadius = 1
        collectionView.layer.masksToBounds = true
        
    }
    
    func editButtonsShape(button: UIButton) {
            
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 1
        button.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
        button.layer.masksToBounds = true

    }
    
}

extension DetailsViewController {
    
    func changeFavBtnImage() {
        
        let setId = comingData.id
        
        if isFavorite {
            FavoriteServiceManager().deleteDataFromAlamofire(id: 108) { result in
                
                switch result {
                case .success(_):
                    print("Sucess")
                case .failure(_):
                    print("Error")
                }
            }
            favBtnShape.setImage(UIImage(named: "heart_like"), for: .normal)
        }
        else {
            FavoriteServiceManager().uploadFavoriteDataToAlamofire(id: setId) { result in
                
                switch result {
                case .success(_):
                    print("Done")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            favBtnShape.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        isFavorite.toggle()
    }
    
}


extension DetailsViewController {
    
    func showDetails() {
        
        SingleHomeDetailsImage.sd_setImage(with: URL(string: "http://13.93.33.202:8000\(comingData.images[0])"), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
        areaDetailsLbl.text = "\(comingData.area) sqrt"
        numberOfRoomsDetailsLbl.text = "\(comingData.bedRoomsNo) rooms"
        numberOfBathroomsDetailsLbl.text = "\(comingData.bathsNo) bathrooms"
        directionDetailsLbl.text = comingData.diriction
        priceDetailsLbl.text = "Rent: \(comingData.price) L.E/month"
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

