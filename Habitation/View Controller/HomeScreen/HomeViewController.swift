//
//  HomeViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/03/2022.
//

import UIKit
import SDWebImage


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
        addBtnToSearchTextField(textField: searchTextField)
        editSearchTextField(textField: searchTextField)
        addImgToSearchTextField(textField: searchTextField, image: UIImage(named: "search")!)
        setupUiForCategoriesCollectionView()
        setupUiForHomeCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        editGreetingLabel()
        
        ComingHomeDataServiceManager().fetchDataFromAlamofire(type: "", name: "") { [self] result in
            
            switch result {

            case .success(let data):
                self.homesArray = data
                self.homeCollectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
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

        ComingHomeDataServiceManager().fetchDataFromAlamofire(type: "", name: search) { [self] result in

            switch result {

            case .success(let data):
                self.homesArray = data
                self.homeCollectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)

            }
        }
    }
    
}

// Collection View delegate and dataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == categoriesCollectionView {
            return categoriesArray.count
        }
        else {
            return homesArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoriesCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
            
            cell.categoryImg.image = UIImage(named: "\(categoriesArray[indexPath.row].image)")
            cell.categoryName.text = categoriesArray[indexPath.row].name
            
            editCollectionViewShape(collectioView: cell)
            
            return cell
            
        }
        else {
            
            let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! SingleHomeCollectionViewCell
                        
            homeCell.homeImg.sd_setImage(with: URL(string: "http://13.93.33.202:8000\(homesArray[indexPath.row].images[0])"), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
            
            homeCell.homePriceLbl.text = "\(homesArray[indexPath.row].price) L.E/month"
            homeCell.areaLbl.text = "\(homesArray[indexPath.row].area) sqrt"
            homeCell.numberOfRoomsLbl.text = "\(homesArray[indexPath.row].bedRoomsNo) rooms"
            homeCell.numberOfBathroomsLbl.text = "\(homesArray[indexPath.row].bathsNo) bathrooms"
            homeCell.setId = homesArray[indexPath.row].id
            homeCell.isFavorite = homesArray[indexPath.row].isFav
            
//            homeCell.favId = favHomesArray[indexPath.row].id
            
            switch homesArray[indexPath.row].isFav {
            case true:
                homeCell.favBtnShape.imageView?.image = UIImage(named: "heart")
            case false:
                homeCell.favBtnShape.imageView?.image = UIImage(named: "heart_like")
            }
            
            editCollectionViewShape(collectioView: homeCell)
            
            return homeCell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == categoriesCollectionView {
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryDetailsVC") as? CategoryDetailsViewController {
                vc.comingNavigationTitle = categoriesArray[indexPath.row].name
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        else {
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController {
                vc.comingData = homesArray[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
    
}

// Collection View design
extension HomeViewController {
    
    func setupUiForCategoriesCollectionView() {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1)), subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        categoriesCollectionView.collectionViewLayout = layout
           
    }
    
    func setupUiForHomeCollectionView() {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1)), subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        homeCollectionView.collectionViewLayout = layout
           
    }
    
}

// Collection View and Search textField shape
extension HomeViewController {
    
    func editCollectionViewShape(collectioView: UICollectionViewCell?) {
        
        _ = collectioView.map {
            
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 0.6
            $0.layer.cornerRadius = 17
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowRadius = 4
            $0.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
            $0.layer.shadowOpacity = 0.1
            $0.layer.masksToBounds = true

        }
    }
    
    func editSearchTextField(textField: UITextField?) {
        
        _ = textField.map {
            
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 0.6
            $0.layer.cornerRadius = 17
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowRadius = 4
            $0.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
            $0.layer.shadowOpacity = 0.1
            $0.layer.masksToBounds = false

        }
    }
    
    func addImgToSearchTextField(textField: UITextField, image: UIImage) {
        
        let imageView = UIImageView(frame: CGRect(x: 27, y: 0, width: image.size.width, height: image.size.height))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: image.size.height))
        view.addSubview(imageView)
        imageView.image = image
        textField.leftView = view
        textField.leftViewMode = .always
        
    }
    
    func addBtnToSearchTextField(textField: UITextField) {
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "search_button"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -45, bottom: 0, right: 0)
//        button.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.searchPressed), for: .touchUpInside)
        textField.rightView = button
        textField.rightViewMode = .always
        
        
        
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

