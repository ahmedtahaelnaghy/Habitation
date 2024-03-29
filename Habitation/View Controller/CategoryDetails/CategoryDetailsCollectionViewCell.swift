//
//  CategoryDetailsCollectionViewCell.swift
//  Habitation
//
//  Created by Ahmed Taha on 27/06/2022.
//

import UIKit

class CategoryDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var numberOfRoomsLbl: UILabel!
    @IBOutlet weak var numberOfBathroomsLbl: UILabel!
    @IBOutlet weak var availabilityBtn: UIButton!
    @IBOutlet weak var favBtnShape: UIButton!
    @IBOutlet weak var homeName: UILabel!
    
    var isFavorite: Bool = false
    var setId: Int = 0
    var favId: Int = 0
    
    @IBAction func favBtn(_ sender: Any) {
        changeFavBtnImage(for: favBtnShape, flag: &isFavorite, itemId: setId, favId: favId)
    }
}
