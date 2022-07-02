//
//  ProfileComingData.swift
//  Habitation
//
//  Created by Ahmed Taha on 02/07/2022.
//

import Foundation

struct ProfileComingData: Codable {
    
    var email: String
    var name: String
    var userPhoneNumber: String?
    var city: String?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        
        case email, name, city
        case userPhoneNumber = "phone_number"
        case image
        
    }
    
}
