//
//  AddNewItem.swift
//  Habitation
//
//  Created by Ahmed Taha on 30/05/2022.
//

import Foundation

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
    
    var images: [String]
    
    var available: Bool
    var direction: String
    
    func isDictionary() -> [String:Any] {

        if let jsonDecodedObj = try? JSONEncoder().encode(self) {

            return try! JSONSerialization.jsonObject(with: jsonDecodedObj) as? [String:Any] ?? [:]
            
        }

        return [:]
        
    } 
    
}
