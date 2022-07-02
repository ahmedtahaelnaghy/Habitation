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
