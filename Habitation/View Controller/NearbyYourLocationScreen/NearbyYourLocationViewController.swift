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
    
    var homesArray: [HomesComingData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearbyCollectionView.delegate = self
        nearbyCollectionView.dataSource = self
        hideKeyboardWhenTappedAround()
        setupItemsDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData(name: "")
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        guard let search = searchTextField.text else {return}
        fetchData(name: search)
    }
}

extension NearbyYourLocationViewController {
    
    func fetchData(name: String) {
        showActivityIndicator()
        ComingHomeDataServiceManager().fetchDataFromAlamofire(type: "", name: name) { [weak self] result in
            self?.hideActivityIndicator()
            switch result {
            case .success(let data):
                self?.homesArray = data
                self?.nearbyCollectionView.reloadData()
            case .failure(_):
                self?.showAlert(message: "Something went wrong!")
            }
        }
    }
    
    func setupItemsDesign() {
        setupVeticalCollectionViewUI(for: nearbyCollectionView)
        addBtnToSearchTextField(textField: searchTextField, action: #selector(self.searchPressed))
        addImageToTextField(textField: searchTextField, imageName: "search", imageViewFrameX: 27)
        editItemsShape(for: [searchTextField as Any], borderColor: .lightGray, borderWidth: 0.6, curveRadius: 17, shadowColor: .black, shadowRadius: 4, shadowOffset: CGSize(width: 0.5, height: 0.5), shadowOpacity: 0.1, masksToBounds: false)
    }
}

//MARK: Collection view implementation.
extension NearbyYourLocationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NearbyYourLocationCollectionViewCell
        setupNearbyCollectionViewCell(for: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController {
            vc.comingData = homesArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setupNearbyCollectionViewCell(for cell: NearbyYourLocationCollectionViewCell, indexPath: IndexPath) {
        setCollectionViewData(for: cell, indexPath: indexPath)
        editItemsShape(for: [cell], borderColor: .lightGray, borderWidth: 0.8, curveRadius: 20, shadowColor: .lightGray, shadowRadius: 1, shadowOffset: CGSize(width: 1.2, height: 1.2), shadowOpacity: 0.5, masksToBounds: true)
    }
    
    func setCollectionViewData(for cell: NearbyYourLocationCollectionViewCell, indexPath: IndexPath) {
        cell.homeImg.sd_setImage(with: URL(string: "http://13.93.33.202:8000\(homesArray[indexPath.row].images[0])"), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
        cell.homePrice.text = "\(homesArray[indexPath.row].price) L.E"
        cell.homeArea.text = "\(homesArray[indexPath.row].area) sqrt"
        cell.numberOfRooms.text = "\(homesArray[indexPath.row].bedRoomsNo) rooms"
        cell.numberOfBathrooms.text = "\(homesArray[indexPath.row].bathsNo) bathrooms"
        cell.setId = homesArray[indexPath.row].id
        cell.isFavorite = homesArray[indexPath.row].isFav
        cell.homeName.text = homesArray[indexPath.row].name
        
        switch homesArray[indexPath.row].isFav {
        case true:
            cell.favBtnShape.imageView?.image = UIImage(named: "heart")
        case false:
            cell.favBtnShape.imageView?.image = UIImage(named: "heart_like")
        }
    }
}
