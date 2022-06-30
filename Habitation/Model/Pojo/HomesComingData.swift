//
//  HomesComingData.swift
//  Habitation
//
//  Created by Ahmed Taha on 28/06/2022.
//

import Foundation

struct HomesComingData: Codable {
    
     let id: Int
     let location: [Double]
     let created, modified, name, description: String
     let isFav, available: Bool
     let price, cashDiscount: String
     let type: String
     let diriction: String
     let area, bathsNo, bedRoomsNo: Int
     let images: [String]

     enum CodingKeys: String, CodingKey {
         case id, location
         case isFav = "is_fav"
         case created, modified, name
         case description = "description"
         case available, price
         case cashDiscount = "cash_discount"
         case type, diriction, area
         case bathsNo = "baths_no"
         case bedRoomsNo = "bed_rooms_no"
         case images
     }
    
}
