//
//  AllDetailsTableViewCell.swift
//  Habitation
//
//  Created by Ahmed Taha on 21/06/2022.
//

import UIKit
import MapKit
import CoreLocation

class AllDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    @IBOutlet weak var homeImagesCollectionView: UICollectionView!

    @IBOutlet weak var map: MKMapView!

    @IBOutlet weak var callBtn: UIButton!
    
    
    
    
    var imagesArray = ["", "", "", "", ""]

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagesCollectionView?.showsHorizontalScrollIndicator = false
        
        homeImagesCollectionView?.delegate = self
        homeImagesCollectionView?.dataSource = self
        
        imagesCollectionView?.dataSource = self
        imagesCollectionView?.dataSource = self
        
        setupUiForImagesCollectionView()
        setupUiForHomeImagesCollectionView()
        
        
        editItems()
    }
    
    func editItems() {
            
        callBtn?.layer.borderColor = UIColor.systemGray.cgColor
        callBtn?.layer.borderWidth = 1
        callBtn?.layer.cornerRadius = 24
        callBtn?.layer.shadowColor = UIColor.lightGray.cgColor
        callBtn?.layer.shadowOpacity = 0.5
        callBtn?.layer.shadowRadius = 1
        callBtn?.layer.shadowOffset = CGSize(width: 1.2, height: 1.2)
        callBtn?.layer.masksToBounds = true

    }
    

}

extension AllDetailsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == homeImagesCollectionView {

            return imagesArray.count

        }

        else {

            return imagesArray.count + 1

        }

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == homeImagesCollectionView {

            let imagesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCell", for: indexPath) as! HomeImagesCollectionViewCell


            imagesCell.homeImages.image = UIImage(named: "Photo")
            
            imagesCell.layer.masksToBounds = true

            return imagesCell
        }
        else {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeImagesCollectionViewCell

            cell.image.image = UIImage(named: "logo")
            cell.layer.cornerRadius = 15
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 2, height: 1)
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowRadius = 1
            cell.layer.masksToBounds = true

            return cell

        }

    }

    func setupUiForImagesCollectionView() {

        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: item, count: 3)

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous

        let layout = UICollectionViewCompositionalLayout(section: section)

        imagesCollectionView?.collectionViewLayout = layout

    }
    
    func setupUiForHomeImagesCollectionView() {

        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous

        let layout = UICollectionViewCompositionalLayout(section: section)

        homeImagesCollectionView?.collectionViewLayout = layout

    }


}


