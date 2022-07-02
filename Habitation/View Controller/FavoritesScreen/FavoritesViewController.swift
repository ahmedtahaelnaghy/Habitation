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
        
        FavoritesCollectionView.delegate = self
        FavoritesCollectionView.dataSource = self
        addBtnToSearchTextField(textField: searchTextField)
        addImgToSearchTextField(textField: searchTextField, image: UIImage(named: "search")!)
        setupUiForCategoriesCollectionView()
        editItems()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchFavHomes()
    }
    
    func fetchFavHomes() {
        
        showActivityIndicator()
        
        FavoriteServiceManager().fetchFavoriteDataFromAlamofire { result in
            self.hideActivityIndicator()
            
            switch result {
            case .success(let data):
                
                self.favHomesArray = data
                self.FavoritesCollectionView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
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
        
        cell.favBtnShape.setImage(UIImage(named: "heart"), for: .normal)
        
        cell.viewController = self
        
        cell.homeImg.sd_setImage(with: URL(string: "http://13.93.33.202:8000\(favHomesArray[indexPath.row].ad.images[0])"), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
        
        cell.homePriceLbl.text = "\(favHomesArray[indexPath.row].ad.price) L.E/month"
        cell.areaLbl.text = "\(favHomesArray[indexPath.row].ad.area) sqrt"
        cell.numberOfRoomsLbl.text = "\(favHomesArray[indexPath.row].ad.bedRoomsNo) rooms"
        cell.numberOfBathroomsLbl.text = "\(favHomesArray[indexPath.row].ad.bathsNo) bathrooms"
        
        cell.favId = favHomesArray[indexPath.row].id
        
        editCollectionViewShape(collectioView: cell)

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController {
            vc.comingData = favHomesArray[indexPath.row].ad
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
// Collection View design
extension FavoritesViewController {
    
    func setupUiForCategoriesCollectionView() {

        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.55)), subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)

        FavoritesCollectionView.collectionViewLayout = layout

    }
    
}

// Collection View and textFields shape
extension FavoritesViewController {
    
    func editCollectionViewShape(collectioView: UICollectionViewCell) {
            
        collectioView.layer.borderColor = UIColor.lightGray.cgColor
        collectioView.layer.borderWidth = 0.8
        collectioView.layer.cornerRadius = 20
        collectioView.layer.shadowColor = UIColor.lightGray.cgColor
        collectioView.layer.shadowOpacity = 0.5
        collectioView.layer.shadowRadius = 1
        collectioView.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
        collectioView.layer.masksToBounds = true
    }
    
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
//        button.addTarget(self, action: #selector(self.searchPressed), for: .touchUpInside)
        textField.rightView = button
        textField.rightViewMode = .always
        
    }
    
}
