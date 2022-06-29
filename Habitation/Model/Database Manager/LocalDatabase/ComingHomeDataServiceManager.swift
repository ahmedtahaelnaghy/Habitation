//
//  ComingHomeDataServiceManager.swift
//  Habitation
//
//  Created by Ahmed Taha on 25/06/2022.
//

import Foundation
import UIKit
import Alamofire

class ComingHomeDataServiceManager {
    
    func uploadDataToAlamofire(unitName: String, description: String, unitPrice: Double, cashPercentageDiscount:Double, type: String, area: Int, location: [Double], numberOfBathrooms: Int, numberOfBedrooms: Int, images: [UIImage], available: Bool, direction: String, completion: @escaping (Result<AddNewItem, Error>) -> (Void)) {
        
        
        
        
        let addNewItemViewModel = AddNewItemViewModel(name: unitName, description: description, price: unitPrice, cashDiscount: cashPercentageDiscount, type: type, area: area, bathsNo: numberOfBathrooms, bedRoomsNo: numberOfBedrooms, location: location, images: images, available: available, diriction: direction)
        
        let parameters = AddNewItem(viewModel: addNewItemViewModel)
        
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
    
    
    func fetchDataFromAlamofire(type: String, completion: @escaping (Result<[HomesComingData], Error>) -> (Void)) {

        guard let url = URL(string: "http://13.93.33.202:8000/api/ads/?type=\(type)") else {return}

        let request = AF.request(url, method: .get, encoding: JSONEncoding.default)

        request.response { dataResponse in

            switch dataResponse.result {

            case .success(let data):

                guard let comingData = try? JSONDecoder().decode([HomesComingData].self, from: data!) else {return}

                completion(.success(comingData))

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
     
}

