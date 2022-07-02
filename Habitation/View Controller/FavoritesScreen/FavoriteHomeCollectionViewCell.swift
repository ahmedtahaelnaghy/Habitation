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
    @IBOutlet weak var homeName: UILabel!
    
    var isFavorite: Bool = true
    var favId: Int = 0

    var viewController: FavoritesViewController!
    
    @IBAction func favBtn(_ sender: Any) {
        changeFavBtnImage()
    }

    func changeFavBtnImage() {
        
        if isFavorite {
            
            FavoriteServiceManager().deleteDataFromAlamofire(id: favId) { result in
                
                switch result {
                case .success(_):
                    self.viewController.fetchFavHomes()
                case .failure(_):
                    print("Error")
                }
                
            }
            favBtnShape.setImage(UIImage(named: "heart_like"), for: .normal)
        }
    }
    
}
