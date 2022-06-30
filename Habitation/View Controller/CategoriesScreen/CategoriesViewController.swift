//
//  CategoriesViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/03/2022.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var allCategoriesCollectionView: UICollectionView!
    
    var categoriesArray:[Categories] = [
                                        Categories(image: "homeIcon", name: "Home"),
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

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.categoryImg.image = UIImage(named: "\(categoriesArray[indexPath.row].image)")
        cell.categoryName.text = categoriesArray[indexPath.row].name
        editCollectionViewShape(collectionView: cell)

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryDetailsVC") as? CategoryDetailsViewController {
            vc.comingNavigationTitle = categoriesArray[indexPath.row].name
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

// Collection View design
extension CategoriesViewController {
    
    func setupUi() {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.22)), subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        allCategoriesCollectionView.collectionViewLayout = layout
        
    }
    
}

// Collection View shape
extension CategoriesViewController {
    
    func editCollectionViewShape(collectionView: UICollectionViewCell) {
        
        collectionView.layer.cornerRadius = 15
        collectionView.layer.borderWidth = 0.5
        collectionView.layer.borderColor = UIColor.lightGray.cgColor
        collectionView.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
        collectionView.layer.shadowColor = UIColor.lightGray.cgColor
        collectionView.layer.shadowOpacity = 0.5
        collectionView.layer.shadowRadius = 1
        collectionView.layer.masksToBounds = false
        
    }
    
}
