//
//  AddNewItem.swift
//  Habitation
//
//  Created by Ahmed Taha on 30/05/2022.
//

import Foundation
import UIKit

struct AddNewItem: Codable {
    
    let location, diriction,type,name, description , available ,price, cashDiscount , area, bathsNo, bedRoomsNo : String
    var images: [Data] = []

    enum CodingKeys: String, CodingKey {
        case location, name
        case description = "description"
        case available, price
        case cashDiscount = "cash_discount"
        case type, diriction, area
        case bathsNo = "baths_no"
        case bedRoomsNo = "bed_rooms_no"
        
    }
    func isDictionary() -> [String:Any] {

        if let jsonDecodedObj = try? JSONEncoder().encode(self) {

            return try! JSONSerialization.jsonObject(with: jsonDecodedObj) as? [String:Any] ?? [:]

        }

        return [:]

    }
    
    init(viewModel: AddNewItemViewModelProtocol){
        self.name = viewModel.name
        self.description = viewModel.description
        self.price = String(viewModel.price)
        self.cashDiscount = String(viewModel.cashDiscount)
        self.type = viewModel.type
        self.area = String(viewModel.area)
        self.bathsNo = String(viewModel.bathsNo)
        self.bedRoomsNo = String(viewModel.bedRoomsNo)
        self.location = "[\(viewModel.location[0]),\((viewModel.location[1]))]"
        self.available = String(viewModel.available)
        self.diriction = viewModel.diriction
        
        self.images = viewModel.images.compactMap({$0.converUIImgaeToData(withQuality: 0.7)})
    }
    
}
