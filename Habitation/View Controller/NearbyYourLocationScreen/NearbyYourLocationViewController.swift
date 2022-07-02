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
        self.hideKeyboardWhenTappedAround()
        nearbyCollectionView.delegate = self
        nearbyCollectionView.dataSource = self
        addBtnToSearchTextField(textField: searchTextField)
        addImgToSearchTextField(textField: searchTextField, image: UIImage(named: "search")!)
        editTextFieldShape(textField: searchTextField)
        setupUiForNearbyCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showActivityIndicator()
        ComingHomeDataServiceManager().fetchDataFromAlamofire(type: "", name: "") { [self] result in
            self.hideActivityIndicator()
            switch result {
            case .success(let data):
                
                self.homesArray = data
                self.nearbyCollectionView.reloadData()

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        
        guard let search = searchTextField.text else {return}

        ComingHomeDataServiceManager().fetchDataFromAlamofire(type: "", name: search) { [self] result in

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
        
        editCollectionViewShape(collectionView: cell)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController {
            vc.comingData = homesArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
        
}

// Collection View design
extension NearbyYourLocationViewController {
    
    func setupUiForNearbyCollectionView() {

        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.55)), subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)

        nearbyCollectionView.collectionViewLayout = layout

    }
    
}

// Collection View and Button shape
extension NearbyYourLocationViewController {
    
    func editCollectionViewShape(collectionView: UICollectionViewCell) {
        
        collectionView.layer.borderColor = UIColor.lightGray.cgColor
        collectionView.layer.borderWidth = 0.8
        collectionView.layer.cornerRadius = 20
        collectionView.layer.shadowColor = UIColor.lightGray.cgColor
        collectionView.layer.shadowOpacity = 0.5
        collectionView.layer.shadowRadius = 1
        collectionView.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
        collectionView.layer.masksToBounds = true
        
    }
    
    func editTextFieldShape(textField: UITextField) {
        
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.6
        textField.layer.cornerRadius = 17
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowRadius = 4
        textField.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        textField.layer.shadowOpacity = 0.1
        textField.layer.masksToBounds = false

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
