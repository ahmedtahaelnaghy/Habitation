//
//  UICollectionViewCell+Extensions.swift
//  Habitation
//
//  Created by Ahmed Taha on 16/10/2022.
//

import UIKit

extension UICollectionViewCell {
    
    func changeFavBtnImage(for button: UIButton, flag: inout Bool, itemId: Int, favId: Int) {
        switch flag {
        case true:
            uploadFavoriteItem(id: itemId)
            button.setImage(UIImage(named: "heart"), for: .normal)
        case false:
            deleteUnFavoriteItem(id: favId)
            button.setImage(UIImage(named: "heart_like"), for: .normal)
        }
        flag.toggle()
    }
    
    func deleteUnFavoriteItem(id: Int) {
        FavoriteServiceManager().deleteDataFromAlamofire(id: id) { result in
            switch result {
            case .success(_):
                print("Sucess")
            case .failure(_):
                print("Error")
            }
        }
    }
    
    func uploadFavoriteItem(id: Int) {
        FavoriteServiceManager().uploadFavoriteDataToAlamofire(id: id) { result in
            switch result {
            case .success(_):
                print("Done")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
