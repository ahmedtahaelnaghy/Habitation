//
//  FavoriteHomeCollectionViewCell.swift
//  Habitation
//
//  Created by Ahmed Taha on 04/05/2022.
//

import UIKit

class FavoriteHomeCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var homePriceLbl: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var numberOfRoomsLbl: UILabel!
    @IBOutlet weak var numberOfBathroomsLbl: UILabel!
    @IBOutlet weak var favBtnShape: UIButton!
    
    var isFav: Bool = true
    
    @IBAction func favBtn(_ sender: Any) {
        
        changeFavBtnImage()
        
    }

    func changeFavBtnImage() {
        
        if isFav {
            
            favBtnShape.setImage(UIImage(named: "heart_like"), for: .normal)
        }
        
    }
    
}
