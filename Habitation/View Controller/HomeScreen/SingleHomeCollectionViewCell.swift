//
//  SingleHomeCollectionViewCell.swift
//  Habitation
//
//  Created by Ahmed Taha on 21/04/2022.
//

import UIKit

class SingleHomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var homePriceLbl: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var numberOfRoomsLbl: UILabel!
    @IBOutlet weak var numberOfBathroomsLbl: UILabel!
    @IBOutlet weak var favBtnShape: UIButton!
    @IBOutlet weak var homeName: UILabel!
    
    var isFavorite: Bool = false
    var setId: Int = 0
    var favId: Int = 0
    
    @IBAction func favBtn(_ sender: Any) {
        changeFavBtnImage(for: favBtnShape, flag: &isFavorite, itemId: setId, favId: favId)
    }
}
