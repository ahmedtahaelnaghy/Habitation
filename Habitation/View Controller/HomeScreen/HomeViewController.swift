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
    
    var categoriesArray: [Categories] = [Categories(image: "homeIcon", name: "Home"),
                                         Categories(image: "apartment", name: "Apartment"),
                                         Categories(image: "office", name: "Office")
     
                                         ]
    
    var homeArray = ["", "" , "", "", "" ,""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        editeSearchTextFieldShape()
        addImgToSearchTextField(textField: searchTextField, image: UIImage(named: "search")!)
        setupUiForCategoriesCollectionView()
        setupUiForHomeCollectionView()
        
    }
    
    func editeSearchTextFieldShape() {
        
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.systemGray.cgColor
        searchTextField.layer.cornerRadius = 33
        
    }
    
    func addImgToSearchTextField(textField: UITextField, image: UIImage) {
        
        let imageView = UIImageView(frame: CGRect(x: 40, y: 0, width: image.size.width, height: image.size.height))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: image.size.height))
        view.addSubview(imageView)
        imageView.image = image
        textField.leftView = view
        textField.leftViewMode = .always
        
    }
    
    @IBAction func categorySeeMoreBtn(_ sender: Any) {
        
        UIView.animate(withDuration: 0.25) {
            self.categoriesCollectionView.layoutIfNeeded()
            self.tabBarController?.selectedIndex = 1
            
        }
        
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == categoriesCollectionView {
            
            return categoriesArray.count
            
        }else {
            
            return homeArray.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoriesCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
            
            cell.categoryImg.image = UIImage(named: "\(categoriesArray[indexPath.row].image)")
            cell.categoryName.text = categoriesArray[indexPath.row].name
            
            cell.layer.cornerRadius = 15
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 1.6, height: 1)
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowRadius = 1
            cell.layer.masksToBounds = false
            
            return cell
            
        }else {
            
            let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! SingleHomeCollectionViewCell
    
            homeCell.homeImg.image = UIImage(named: "logo")
            homeCell.layer.cornerRadius = 15
            homeCell.layer.borderWidth = 0.5
            homeCell.layer.borderColor = UIColor.lightGray.cgColor
            homeCell.layer.shadowOffset = CGSize(width: 2, height: 1)
            homeCell.layer.shadowColor = UIColor.lightGray.cgColor
            homeCell.layer.shadowOpacity = 0.5
            homeCell.layer.shadowRadius = 1
            homeCell.layer.masksToBounds = false
            
            return homeCell
            
        }
        
    }
    
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
