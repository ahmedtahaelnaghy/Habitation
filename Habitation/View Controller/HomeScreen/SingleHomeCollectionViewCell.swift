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
    
    var isfav: Bool = false
    
    @IBAction func favBtn(_ sender: Any) {
        
        changeFavBtnImage()
    }
    
    func changeFavBtnImage() {
        
        if isfav {
            
                favBtnShape.setImage(UIImage(named: "heart_like"), for: .normal)
        }
        else {
            
            let userDefaults = UserDefaults.standard
            let myId = userDefaults.string(forKey: "id") ?? ""
            
            FavoriteServiceManager().uploadFavoriteDataToAlamofire(id: myId) { result in
                print(result)
                switch result {
                    
                case .success(_):
                    print("Done")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            favBtnShape.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        isfav.toggle()
    }
    
}
