//
//  CategoryDetailsViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 27/06/2022.
//

import UIKit

class CategoryDetailsViewController: UIViewController {

    @IBOutlet weak var categoryDetailsCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var homesArray: [HomesComingData] = []
    
    var comingNavigationTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryDetailsCollectionView.delegate = self
        categoryDetailsCollectionView.dataSource = self
        navigationItem.title = comingNavigationTitle
        addBtnToSearchTextField(textField: searchTextField, action: #selector(self.searchPressed))
        addImageToTextField(textField: searchTextField, imageName: "search", imageViewFrameX: 27)
        editItemsShape(for: [searchTextField!], borderColor: .lightGray, borderWidth: 0.6, curveRadius: 17, shadowColor: .black, shadowRadius: 4, shadowOffset: CGSize(width: 0.5, height: 0.5), shadowOpacity: 0.1, masksToBounds: false)
        setupVeticalCollectionViewUI(for: categoryDetailsCollectionView)
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
       fetchData(type: comingNavigationTitle, name: "")
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        guard let search = searchTextField.text else {return}
        fetchData(type: comingNavigationTitle, name: search)
    }
    
    func fetchData(type: String, name: String) {
        showActivityIndicator()
        ComingHomeDataServiceManager().fetchDataFromAlamofire(type: type, name: name) { [weak self] result in
            self?.hideActivityIndicator()
            switch result {
            case .success(let data):
                self?.homesArray = data
                self?.categoryDetailsCollectionView.reloadData()
            case .failure(_):
                self?.showAlert(message: "Something wrong")
            }
        }
    }
}

// MARK: -> Category details collection view implementation.
extension CategoryDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryDetailsCollectionViewCell
        setDataInCollectionView(for: cell, indexPath: indexPath)
        editItemsShape(for: [cell], borderColor: .lightGray, borderWidth: 0.8, curveRadius: 20, shadowColor: .lightGray, shadowRadius: 1, shadowOffset: CGSize(width: 1.2, height: 1.2), shadowOpacity: 0.5, masksToBounds: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController {
            vc.comingData = homesArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setDataInCollectionView(for cell: CategoryDetailsCollectionViewCell, indexPath: IndexPath) {
        cell.homeImg.setImage(for: homesArray[indexPath.row].images[0])
        cell.priceLbl.text = "\(homesArray[indexPath.row].price) L.E"
        cell.areaLbl.text = "\(homesArray[indexPath.row].area) sqrt"
        cell.numberOfRoomsLbl.text = "\(homesArray[indexPath.row].bedRoomsNo) rooms"
        cell.numberOfBathroomsLbl.text = "\(homesArray[indexPath.row].bathsNo) bathrooms"
        cell.setId = homesArray[indexPath.row].id
        cell.homeName.text = homesArray[indexPath.row].name
        cell.isFavorite = homesArray[indexPath.row].isFav
        
        switch homesArray[indexPath.row].isFav {
        case true:
            cell.favBtnShape.imageView?.image = UIImage(named: "heart")
        case false:
            cell.favBtnShape.imageView?.image = UIImage(named: "heart_like")
        }
    }
}
