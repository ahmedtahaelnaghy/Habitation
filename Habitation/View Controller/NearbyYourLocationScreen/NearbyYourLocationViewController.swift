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
    
    var homeArray = ["", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nearbyCollectionView.delegate = self
        nearbyCollectionView.dataSource = self
        
        addImgToSearchTextField(textField: searchTextField, image: UIImage(named: "search")!)
        
        editItems()
        
        setupUiForNearbyCollectionView()
        
    }
    
    
    
}

extension NearbyYourLocationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NearbyYourLocationCollectionViewCell
        
        cell.homeImg.image = UIImage(named: "unit5")
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.8
        cell.layer.cornerRadius = 20
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 1
        cell.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
        cell.layer.masksToBounds = true
            
        return cell
        
    }
    
    func setupUiForNearbyCollectionView() {

        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.55)), subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)

        nearbyCollectionView.collectionViewLayout = layout

    }

    
    
    
    
    
    
    
    
    
}


extension NearbyYourLocationViewController {
    
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
        
        let imageView = UIImageView(frame: CGRect(x: 35, y: 0, width: image.size.width, height: image.size.height))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: image.size.height))

        view.addSubview(imageView)

        imageView.image = image

        textField.leftView = view
        textField.leftViewMode = .always
        
    }
    
}
