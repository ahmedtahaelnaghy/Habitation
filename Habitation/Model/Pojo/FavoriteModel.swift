//
//  FavoriteModel.swift
//  Habitation
//
//  Created by Ahmed Taha on 29/06/2022.
//

import Foundation

struct FavoriteId: Codable {
    
    let id: Int
    let ad: FavoriteModel
    
}

struct FavoriteModel: Codable {
    
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

