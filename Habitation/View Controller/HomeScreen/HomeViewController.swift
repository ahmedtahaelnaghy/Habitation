//
//  HomeViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 18/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
   
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    var categoriesArray: [Categories] = [Categories(image: "homeIcon", name: "Home"),
                                         Categories(image: "apartment", name: "Apartment"),
                                         Categories(image: "office", name: "Office")
     
                                         ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        editeSearchTextFieldShape()
        
        addImgToSearchTextField(textField: searchTextField, image: UIImage(named: "search")!)
        
        setupUi()
        
                
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


}



extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        
        cell.categoryImg.image = UIImage(named: "\(categoriesArray[indexPath.row].image)")
        cell.categoryName.text = categoriesArray[indexPath.row].name
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 0.75
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        return cell
        
    }
    
    func setupUi() {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1)), subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        categoriesCollectionView.collectionViewLayout = layout
           
    }
    
}

