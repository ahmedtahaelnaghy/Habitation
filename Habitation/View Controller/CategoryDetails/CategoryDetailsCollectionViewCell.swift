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
        changeFavBtnImage()
    }

    func changeFavBtnImage() {
        
        if isFavorite {
            FavoriteServiceManager().deleteDataFromAlamofire(id: 108) { result in
                
                switch result {
                case .success(_):
                    print("Sucess")
                case .failure(_):
                    print("Error")
                }
            }
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
        
        isFavorite.toggle()
    }
    
}
