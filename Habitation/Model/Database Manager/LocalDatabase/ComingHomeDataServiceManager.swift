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

