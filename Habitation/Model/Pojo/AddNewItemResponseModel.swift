//
//  AddNewItemResponseModel.swift
//  Habitation
//
//  Created by Ahmed Taha on 28/06/2022.
//

import Foundation


struct AddNewItemResponseModel: Codable {
    
    let id: Int
     let location: [Int]
     let created, modified, name, welcomeDescription: String
     let available: Bool
     let price, cashDiscount, type, diriction: String
     let area, bathsNo, bedRoomsNo: Int
     let images: [String]

     enum CodingKeys: String, CodingKey {
         case id, location, created, modified, name
         case welcomeDescription = "description"
         case available, price
         case cashDiscount = "cash_discount"
         case type, diriction, area
         case bathsNo = "baths_no"
         case bedRoomsNo = "bed_rooms_no"
         case images
     }
    
}
