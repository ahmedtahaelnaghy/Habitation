//
//  AddNewItem.swift
//  Habitation
//
//  Created by Ahmed Taha on 30/05/2022.
//

import Foundation
import UIKit

struct AddNewItem: Codable {
    
    var name: String
    var description: String
    
    var price: Double
    var cash_discount: Double
    
    var type: String
    var area: Int
    var baths_no: Int
    var bed_rooms_no: Int
    var location: [Double]
    
    var images: [Data]
    
    var available: Bool
    var diriction: String
    
    func isDictionary() -> [String:Any] {

        if let jsonDecodedObj = try? JSONEncoder().encode(self) {

            return try! JSONSerialization.jsonObject(with: jsonDecodedObj) as? [String:Any] ?? [:]

        }

        return [:]

    }
    
    init(viewModel: AddNewItemViewModelProtocol){
        self.name = viewModel.name
        self.description = viewModel.description
        self.price = viewModel.price
        self.cash_discount = viewModel.cashDiscount
        self.type = viewModel.type
        self.area = viewModel.area
        self.baths_no = viewModel.bathsNo
        self.bed_rooms_no = viewModel.bedRoomsNo
        self.location = viewModel.location
        self.available = viewModel.available
        self.diriction = viewModel.diriction
        
        self.images = viewModel.images.compactMap({$0.converUIImgaeToData(withQuality: 0.7)})
    }
    
}
