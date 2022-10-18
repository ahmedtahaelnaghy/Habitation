//
//  CategoriesViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/03/2022.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var allCategoriesCollectionView: UICollectionView!
    
    var categoriesArray:[Categories] = [Categories(image: "homeIcon", name: "Home"),
                                        Categories(image: "hotel", name: "Hotel"),
                                        Categories(image: "apartment", name: "Apartment"),
                                        Categories(image: "office", name: "Office"),
                                        Categories(image: "flat", name: "Flat"),
                                        Categories(image: "palace", name: "Palace") ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

//MARK: -> Collection view implementation.
extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell
        setupCollectionViewDesign(for: cell)
        setCollectionViewData(for: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToCategoryDetails(indexPath: indexPath)
    }
    
}

//MARK: -> Set data and design categories collection view.
extension CategoriesViewController {
    
    func setupCollectionViewDesign(for cell: UICollectionViewCell) {
        setupVeticalCollectionViewUI(for: allCategoriesCollectionView, height: 0.22, leading: 10, trailing: 10, count: 2)
        editItemsShape(for: [cell], borderColor: .lightGray, borderWidth: 0.5, curveRadius: 15, shadowColor: .lightGray, shadowRadius: 1, shadowOffset: CGSize(width: 1.2, height: 1.2), shadowOpacity: 0.5, masksToBounds: false)
    }
    
    func setCollectionViewData(for cell: CategoryCollectionViewCell, indexPath: IndexPath) {
        cell.categoryImg.image = UIImage(named: "\(categoriesArray[indexPath.row].image)")
        cell.categoryName.text = categoriesArray[indexPath.row].name
    }
    
    func goToCategoryDetails(indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryDetailsVC") as? CategoryDetailsViewController {
            vc.comingNavigationTitle = categoriesArray[indexPath.row].name
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
