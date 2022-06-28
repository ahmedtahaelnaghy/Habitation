//
//  NearbyYourLocationViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 16/06/2022.
//

import UIKit

class NearbyYourLocationViewController: UIViewController {
    
    @IBOutlet weak var nearbyCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var homesArray:[HomesComingData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nearbyCollectionView.delegate = self
        nearbyCollectionView.dataSource = self
        
        addImgToSearchTextField(textField: searchTextField, image: UIImage(named: "search")!)
        editItems()
        setupUiForNearbyCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        ComingHomeDataServiceManager().fetchDataFromAlamofire(type: "") { [self] result in
            
            switch result {

            case .success(let data):
                
                self.homesArray = data
                self.nearbyCollectionView.reloadData()

            case .failure(let error):
                print(error.localizedDescription)
            }

        }
        
    }
    
}

extension NearbyYourLocationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NearbyYourLocationCollectionViewCell
        
        cell.homeImg.sd_setImage(with: URL(string: "http://13.93.33.202:8000\(homesArray[indexPath.row].images[0])"), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
        
        cell.homePrice.text = "\(homesArray[indexPath.row].price) L.E/month"
        cell.homeArea.text = "\(homesArray[indexPath.row].area) sqrt"
        cell.numberOfRooms.text = "\(homesArray[indexPath.row].bedRoomsNo) rooms"
        cell.numberOfBathrooms.text = "\(homesArray[indexPath.row].bathsNo) bathrooms"
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.8
        cell.layer.cornerRadius = 20
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 1
        cell.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
        cell.layer.masksToBounds = true
            
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController {
            vc.comingData = homesArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        
        }
    }
        
    
    func setupUiForNearbyCollectionView() {

        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.55)), subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)

        nearbyCollectionView.collectionViewLayout = layout

    }
    
}


extension NearbyYourLocationViewController {
    
    func editItems() {
        
        let itemsArray = [searchTextField]
        
        _ = itemsArray.map {
            
            $0!.layer.borderColor = UIColor.lightGray.cgColor
            $0!.layer.borderWidth = 0.6
            $0!.layer.cornerRadius = 17
            $0!.layer.shadowColor = UIColor.black.cgColor
            $0!.layer.shadowRadius = 4
            $0!.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
            $0!.layer.shadowOpacity = 0.1
            $0!.layer.masksToBounds = false

        }
    }
    
    func addImgToSearchTextField(textField: UITextField, image: UIImage) {
        
        let imageView = UIImageView(frame: CGRect(x: 35, y: 0, width: image.size.width, height: image.size.height))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: image.size.height))
        view.addSubview(imageView)
        imageView.image = image
        textField.leftView = view
        textField.leftViewMode = .always
        
    }
    
}
