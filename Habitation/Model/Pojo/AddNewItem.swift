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
    
    var price: String
    var cash_discount: String
    
    var type: String
    var area: String
    var baths_no: Int
    var bed_rooms_no: Int
    var direction: String
    
    var images: String
    
    
    func isDictionary() -> [String:Any] {

        if let jsonDecodedObj = try? JSONEncoder().encode(self) {

            return try! JSONSerialization.jsonObject(with: jsonDecodedObj) as? [String:Any] ?? [:]
            
        }

        return [:]
        
    } 
    
}
