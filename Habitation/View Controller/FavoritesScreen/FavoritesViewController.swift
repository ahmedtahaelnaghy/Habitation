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
    
    
    var favArray = ["", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FavoritesCollectionView.delegate = self
        FavoritesCollectionView.dataSource = self
        
        addImgToSearchTextField(textField: searchTextField, image: UIImage(named: "search")!)
        editItems()
        
    }
    
    func editItems() {
        
        let itemsArray = [searchTextField]
        
        _ = itemsArray.map {
            
            $0!.layer.borderColor = UIColor.lightGray.cgColor
            $0!.layer.borderWidth = 1
            $0!.layer.cornerRadius = 30
            $0!.layer.shadowColor = UIColor.lightGray.cgColor
            $0!.layer.shadowOpacity = 0.5
            $0!.layer.shadowRadius = 1
            $0!.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
            $0!.layer.masksToBounds = false

        }
    }
    
    func addImgToSearchTextField(textField: UITextField, image: UIImage) {
        
        let imageView = UIImageView(frame: CGRect(x: 40, y: 0, width: image.size.width, height: image.size.height))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: image.size.height))

        view.addSubview(imageView)

        imageView.image = image

        textField.leftView = view
        textField.leftViewMode = .always
        
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return favArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavCell", for: indexPath) as! FavoriteHomeCollectionViewCell
        
        cell.image.image = UIImage(named: "logo")
            
            
        
        return cell
        
    }
    
    func setupUiForCategoriesCollectionView() {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
                
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        FavoritesCollectionView.collectionViewLayout = layout
           
    }
    
    
}
