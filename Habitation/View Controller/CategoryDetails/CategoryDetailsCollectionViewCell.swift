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
    
    var isFav: Bool = false
    var setId: Int = 0
    
    @IBAction func favBtn(_ sender: Any) {
        
        changeFavBtnImage()
        
    }

    func changeFavBtnImage() {
        
        if isFav {
            
            favBtnShape.setImage(UIImage(named: "heart_like"), for: .normal)
        }
        else {
            
            
            FavoriteServiceManager().uploadFavoriteDataToAlamofire(id: setId) { result in
                
                switch result {
                    
                case .success(_):
                    print("Done")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            favBtnShape.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        isFav.toggle()
        
    }

    
    
    
}
