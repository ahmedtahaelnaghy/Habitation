//
//  ComingHomeDataServiceManager.swift
//  Habitation
//
//  Created by Ahmed Taha on 25/06/2022.
//

import Foundation
import Alamofire

class ComingHomeDataServiceManager {
    
    func homeData(unitName: String, description: String, unitPrice: Int, cashPercentageDiscount:Double, type: String, area: Int, location: String, numberOfBathrooms: Int, numberOfBedrooms: Int, images: [String], available: Bool, direction: String, completion: @escaping (Result<AddNewItem, Error>) -> (Void)) {
        
        let parameters = AddNewItem(name: unitName, description: description, price: unitPrice, cash_discount: cashPercentageDiscount, type: type, area: area, baths_no: numberOfBathrooms, bed_rooms_no: numberOfBedrooms, location: location, images: images, available: available, direction: direction)
        
        let parametersDic = parameters.isDictionary()
        
        guard let url = URL(string: "http://13.93.33.202:8000/api/ads/") else {return}
        
        let request = AF.request(url, method: .post, parameters: parametersDic, encoding: JSONEncoding.default)
        
        request.response { (dataResponse) in
            
            switch dataResponse.result {
                
                
            case .success(let data):
                
                print("My data")
                
                guard let addNewItem = try? JSONDecoder().decode(AddNewItem.self, from: data!) else {return}
                
                print(addNewItem)
                
                completion(.success(addNewItem))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

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

