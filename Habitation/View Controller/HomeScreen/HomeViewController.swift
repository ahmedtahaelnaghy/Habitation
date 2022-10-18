//
//  HomeViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var welcomeLbl: UILabel!
    
    var categoriesArray: [Categories] = [
                                         Categories(image: "homeIcon", name: "Home"),
                                         Categories(image: "apartment", name: "Apartment"),
                                         Categories(image: "office", name: "Office")
                                        ]
    
    var homesArray: [HomesComingData] = []
    var favHomesArray: [FavoriteId] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        setupViewControllerItemsDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        editGreetingLabel()
        fetchData(for: "")
    }
    
    @IBAction func categorySeeMoreBtn(_ sender: Any) {
            self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func nearbyYourLocationSeeMoreBtn(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NearbyVC") as? NearbyYourLocationViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func addBtn(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewHomeVC") as? AddNewHomeViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        guard let search = searchTextField.text else {return}
        fetchData(for: search)
    }
}

extension HomeViewController {
    
    func fetchData(for search: String) {
        showActivityIndicator()
        ComingHomeDataServiceManager().fetchDataFromAlamofire(type: "", name: search) { [weak self] result in
            self?.hideActivityIndicator()
            switch result {
            case .success(let data):
                self?.homesArray = data
                self?.homeCollectionView.reloadData()
            case .failure(_):
                self?.showAlert(message: "Something wrong")
            }
        }
    }
    
    func setupViewControllerItemsDesign() {
        setupHorizontalCollectionViewUI(for: categoriesCollectionView, groupWidth: 0.4)
        setupHorizontalCollectionViewUI(for: homeCollectionView, groupWidth: 0.9)
        addBtnToSearchTextField(textField: searchTextField, action: #selector(self.searchPressed))
        addImageToTextField(textField: searchTextField, imageName: "search", imageViewFrameX: 27)
        editItemsShape(for: [searchTextField as Any], borderColor: .lightGray, borderWidth: 0.6, curveRadius: 17, shadowColor: .black, shadowRadius: 4, shadowOffset: CGSize(width: 0.5, height: 0.5), shadowOpacity: 0.1, masksToBounds: true)
    }
}

// MARK: Collections View implementation.
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        checkCollectionViewName(for: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! SingleHomeCollectionViewCell
        
        editItemsShape(for: [cell, homeCell], borderColor: .lightGray, borderWidth: 0.6, curveRadius: 17, shadowColor: .black, shadowRadius: 4, shadowOffset: CGSize(width: 0.5, height: 0.5), shadowOpacity: 0.1, masksToBounds: true)
        
        if collectionView == categoriesCollectionView {
            setHomeCollectionViewCellItems(for: cell, indexPath: indexPath)
            return cell
        }
        else {
            setSingleHomeCollectionViewCellItems(for: homeCell, indexPath: indexPath)
            return homeCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollectionView {
            goToCategoryDetails(indexPath: indexPath)
        } else {
            goToDetails(indexPath: indexPath)
        }
    }
    
    func goToCategoryDetails(indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryDetailsVC") as? CategoryDetailsViewController {
            vc.comingNavigationTitle = categoriesArray[indexPath.row].name
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func goToDetails(indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController {
            vc.comingData = homesArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func checkCollectionViewName(for collectionView: UICollectionView) -> Int {
        if collectionView == categoriesCollectionView {
            return categoriesArray.count
        }
        else {
            return homesArray.count
        }
    }
    
    func setHomeCollectionViewCellItems(for cell: HomeCollectionViewCell, indexPath: IndexPath) {
        cell.categoryImg.image = UIImage(named: "\(categoriesArray[indexPath.row].image)")
        cell.categoryName.text = categoriesArray[indexPath.row].name
    }
    
    func setSingleHomeCollectionViewCellItems(for cell: SingleHomeCollectionViewCell, indexPath: IndexPath) {
        cell.homeImg.setImage(for: homesArray[indexPath.row].images[0])
        cell.homePriceLbl.text = "\(homesArray[indexPath.row].price) L.E"
        cell.areaLbl.text = "\(homesArray[indexPath.row].area) sqrt"
        cell.numberOfRoomsLbl.text = "\(homesArray[indexPath.row].bedRoomsNo) rooms"
        cell.numberOfBathroomsLbl.text = "\(homesArray[indexPath.row].bathsNo) bathrooms"
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

// Change Greeting label with time
extension HomeViewController {
    
    func editGreetingLabel() {
        let userDefaults = UserDefaults.standard
        guard let userName = userDefaults.string(forKey: "name") else {return}
        welcomeLbl.text = getGreeting(userName: userName)
    }
    
    private func getGreeting(userName: String) -> String {
        
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<4:
            return "Hello, \(userName)"
        case 4..<12:
            return "Good Morning, \(userName)"
        case 12..<18:
            return "Good Afternoon, \(userName)"
        case 18..<24:
            return "Good Evening, \(userName)"
        default:
            break
            
        }
        return "Hello"
    }
}
