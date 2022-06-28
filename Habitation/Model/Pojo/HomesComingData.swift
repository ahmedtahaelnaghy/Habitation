//
//  HomesComingData.swift
//  Habitation
//
//  Created by Ahmed Taha on 28/06/2022.
//

import Foundation

struct HomesComingData: Codable {
    
//    var id: Int
//    var location: [Double]
//    var created: String
//    var modified: String
//    var name: String
//    var description: String
//    var available: Bool
//    var price: Double
//    var cash_discount: Double
//    var type: String
//    var diriction: String
//    var area: Int
//    var baths_no: Int
//    var bed_rooms_no: Int
//    var images: [String]
    
    
        let id: Int
        let location: [Double]
        let created, modified, name, description: String
        let available: Bool
        let price, cashDiscount, type, diriction: String
        let area, bathsNo, bedRoomsNo: Int
        let images: [String]

        enum CodingKeys: String, CodingKey {
            case id, location, created, modified, name
            case description = "description"
            case available, price
            case cashDiscount = "cash_discount"
            case type, diriction, area
            case bathsNo = "baths_no"
            case bedRoomsNo = "bed_rooms_no"
            case images
        }

    
}
