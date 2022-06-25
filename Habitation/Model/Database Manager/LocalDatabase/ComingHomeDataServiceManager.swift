//
//  ComingHomeDataServiceManager.swift
//  Habitation
//
//  Created by Ahmed Taha on 25/06/2022.
//

import Foundation
import Alamofire

class ComingHomeDataServiceManager {
    
    
    func homeData(unitName: String, description: String, unitPrice: String, cashPercentageDiscount:String, type: String, area: String, location: String, numberOfBathrooms: Int, numberOfBedrooms: Int, images: String) {
        
//        let parameters = [
//
//            "name": unitName,
//            "description": description,
//            "price": unitPrice,
//            "cash_discount": cashPercentageDiscount,
//            "type": type,
//            "area": area,
//            "direction": location,
//            "baths_no": numberOfBathrooms,
//            "bed_rooms_no": numberOfBedrooms,
//            "images": images
//
//        ]
        
        let parameters = AddNewItem(name: unitName, description: description, price: unitPrice, cash_discount: cashPercentageDiscount, type: type, area: area, baths_no: numberOfBathrooms, bed_rooms_no: numberOfBedrooms, direction: location, images: images)
        
        let parametersDic = parameters.isDictionary()
        
        guard let url = URL(string: "") else {return}
        
        let request = AF.request(url, method: .post, parameters: parametersDic, encoding: JSONEncoding.default)
        
//        request.response { (dataResponse) in
//            <#code#>
//        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



