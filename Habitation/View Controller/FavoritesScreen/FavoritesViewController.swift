//
//  FavoritesViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/03/2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var FavoritesCollectionView: UICollectionView!
    
    var favHomesArray: [FavoriteId] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        FavoritesCollectionView.delegate = self
        FavoritesCollectionView.dataSource = self
        addBtnToSearchTextField(textField: searchTextField, action: #selector(self.searchPressed))
        addImageToTextField(textField: searchTextField, imageName: "search", imageViewFrameX: 27)
        setupVeticalCollectionViewUI(for: FavoritesCollectionView)
        editItemsShape(for: [searchTextField!], borderColor: .lightGray, borderWidth: 0.6, curveRadius: 17, shadowColor: .black, shadowRadius: 4, shadowOffset: CGSize(width: 0.5, height: 0.5), shadowOpacity: 0.1, masksToBounds: false)        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFavHomes()
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        fetchFavHomes()
    }
    
    func fetchFavHomes() {
        showActivityIndicator()
        FavoriteServiceManager().fetchFavoriteDataFromAlamofire { [weak self] result in
            self?.hideActivityIndicator()
            switch result {
            case .success(let data):
                self?.favHomesArray = data
                self?.FavoritesCollectionView.reloadData()
            case .failure(_):
                self?.showAlert(message: "Something wrong")
            }
        }
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favHomesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavoriteHomeCollectionViewCell
        setFavoritesCollectionViewData(for: cell, indexPath: indexPath)
        editItemsShape(for: [cell], borderColor: .lightGray, borderWidth: 0.8, curveRadius: 20, shadowColor: .lightGray, shadowRadius: 1, shadowOffset: CGSize(width: 1.2, height: 1.2), shadowOpacity: 0.5, masksToBounds: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController {
            vc.comingData = favHomesArray[indexPath.row].ad
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setFavoritesCollectionViewData(for cell: FavoriteHomeCollectionViewCell, indexPath: IndexPath) {
        cell.viewController = self
        cell.favBtnShape.setImage(UIImage(named: "heart"), for: .normal)
        cell.homeImg.setImage(for: favHomesArray[indexPath.row].ad.images[0])
        cell.homePriceLbl.text = "\(favHomesArray[indexPath.row].ad.price) L.E"
        cell.areaLbl.text = "\(favHomesArray[indexPath.row].ad.area) sqrt"
        cell.numberOfRoomsLbl.text = "\(favHomesArray[indexPath.row].ad.bedRoomsNo) rooms"
        cell.numberOfBathroomsLbl.text = "\(favHomesArray[indexPath.row].ad.bathsNo) bathrooms"
        cell.homeName.text = favHomesArray[indexPath.row].ad.name
        cell.favId = favHomesArray[indexPath.row].id
    }

}
