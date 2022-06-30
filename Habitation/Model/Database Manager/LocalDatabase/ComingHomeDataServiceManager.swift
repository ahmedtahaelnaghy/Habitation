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
    
    func fetchDataFromAlamofire(type: String, name: String, completion: @escaping (Result<[HomesComingData], Error>) -> (Void)) {

        guard let comingToken = UserDefaults.standard.string(forKey: "token") else {return}

        guard let url = URL(string: "http://13.93.33.202:8000/api/ads/?type=\(type)&name=\(name)") else {return}
        
        let request = AF.request(url, method: .get, headers: [HTTPHeader(name: "Authorization", value: "token \(comingToken)")])
        
        request.response { dataResponse in

            switch dataResponse.result {

            case .success(let data):
                
                if dataResponse.response!.statusCode > 299 {
                    completion(.failure(CustomError(title: "", description: "Your email or password incorrect", code: 100)))
                    return
                }
                
                guard let comingData = try? JSONDecoder().decode([HomesComingData].self, from: data!) else {return}
                
                completion(.success(comingData))

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
     
}

