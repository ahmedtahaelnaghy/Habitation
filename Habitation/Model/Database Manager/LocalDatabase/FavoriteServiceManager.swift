//
//  FavoriteServiceManager.swift
//  Habitation
//
//  Created by Ahmed Taha on 29/06/2022.
//

import Foundation
import Alamofire

class FavoriteServiceManager {
    
    func uploadFavoriteDataToAlamofire(id: Int, completion: @escaping(Result<FavoriteId, Error>) -> (Void)) {
        
        guard let comingToken = UserDefaults.standard.string(forKey: "token") else {return}
        
        let parameter = ["ad_id": id]
        
        guard let url = URL(string: "http://13.93.33.202:8000/api/favourite/") else {return}
        
        let request = AF.request(url, method: .post, parameters: parameter, headers: [HTTPHeader(name: "Authorization", value: "token \(comingToken)")])
        
        request.response { dataResponse in
            
            switch dataResponse.result {
                
            case .success(let data):
                
                if dataResponse.response!.statusCode > 299 {
                    completion(.failure(CustomError(title: "", description: "Your email or password incorrect", code: 100)))
                    return
                }
                
                guard let dataModel = try? JSONDecoder().decode(FavoriteId.self, from: data!) else {return}
                
                completion(.success(dataModel))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func fetchFavoriteDataFromAlamofire(completion: @escaping (Result<[FavoriteId], Error>) -> (Void)) {
        
        guard let comingToken = UserDefaults.standard.string(forKey: "token") else {return}
        guard let url = URL(string: "http://13.93.33.202:8000/api/favourite/") else {return}
        
        let request = AF.request(url, method: .get, headers: [HTTPHeader(name: "Authorization", value: "token \(comingToken)")])
                
        request.response { dataResponse in

            switch dataResponse.result {

            case .success(let data):
                
                if dataResponse.response!.statusCode > 299 {
                    completion(.failure(CustomError(title: "", description: "Your email or password incorrect", code: 100)))
                    return
                }
                
                guard let comingData = try? JSONDecoder().decode([FavoriteId].self, from: data!) else {return}
                
                completion(.success(comingData))

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteDataFromAlamofire(id: Int, completion: @escaping(Result<DeleteFavResponse, Error>) -> (Void)) {
        
        guard let comingToken = UserDefaults.standard.string(forKey: "token") else {return}
        guard let url = URL(string: "http://13.93.33.202:8000/api/favourite/\(id)/") else {return}
        
        let request = AF.request(url, method: .delete, headers: [HTTPHeader(name: "Authorization", value: "token \(comingToken)")])
        
        request.response { dataResponse in
            
            if let error = dataResponse.error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            completion(.success(DeleteFavResponse()))
        }
    }
    
}
