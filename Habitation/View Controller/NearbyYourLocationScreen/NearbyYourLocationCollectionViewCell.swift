//
//  NearbyYourLocationCollectionViewCell.swift
//  Habitation
//
//  Created by Ahmed Taha on 16/06/2022.
//

import UIKit

class NearbyYourLocationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var homePrice: UILabel!
    @IBOutlet weak var homeArea: UILabel!
    @IBOutlet weak var numberOfRooms: UILabel!
    @IBOutlet weak var numberOfBathrooms: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var favBtnShape: UIButton!
    @IBOutlet weak var homeName: UILabel!
    
    var isFavorite: Bool = false
    var setId: Int = 0
    var favId: Int = 0
    
    @IBAction func favBtn(_ sender: Any) {
        changeFavBtnImage(for: favBtnShape, flag: &isFavorite, itemId: setId, favId: favId)
    }
}
