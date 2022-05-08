//
//  CategoriesViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/03/2022.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    var categoriesArray:[Categories] = [Categories(image: "homeIcon", name: "Home"),
                                        Categories(image: "hotel", name: "Hotel"),
                                        Categories(image: "apartment", name: "Apartment"),
                                        Categories(image: "office", name: "Office"),
                                        Categories(image: "flat", name: "Flat"),
                                        Categories(image: "palace", name: "Palace")
                                        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUi()
        
    }
    
}

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categoriesArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.categoryImg.image = UIImage(named: "\(categoriesArray[indexPath.row].image)")
        cell.categoryName.text = categoriesArray[indexPath.row].name
        
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 1
        
        cell.layer.masksToBounds = false

        return cell
        
    }
    
    func setupUi() {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.22)), subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        categoriesCollectionView.collectionViewLayout = layout
        
    }
    
}



