//
//  ProfileServiceManager.swift
//  Habitation
//
//  Created by Ahmed Taha on 02/07/2022.
//

import Foundation
import Alamofire

class ProfileServiceManager {
    
    func fetchProfileDataFromAlamofire(completion: @escaping(Result<ProfileComingData, Error>) -> (Void)) {
        
        guard let comingToken = UserDefaults.standard.string(forKey: "token") else {return}
        guard let url = URL(string: "http://13.93.33.202:8000/api/users/me/") else {return}
        
        let request = AF.request(url, method: .get, headers: [HTTPHeader(name: "Authorization", value: "token \(comingToken)")])
        
        request.response { dataResponse in
            
            switch dataResponse.result {
                
            case .success(let data):
                
                guard let comingProfileData = try? JSONDecoder().decode(ProfileComingData.self, from: data!) else {return}
                completion(.success(comingProfileData))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func editProfileFromAlamofire(city: String, phoneNumber: String,image: [Data] , completion: @escaping(Result<ProfileComingData, Error>) -> (Void)) {
        
        let parameter = ["city" : city, "phone_number" : phoneNumber] as [String : Any]
        guard let comingToken = UserDefaults.standard.string(forKey: "token") else {return}
        
        var acceptableStatusCodes = [] + (200..<300).reversed() + (400..<500).reversed()

        AF.upload(multipartFormData: { multipartFormData in
                    // import image to request
            for image in image {
                multipartFormData.append(image, withName: "image", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            

            for (key, value) in parameter {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            
            }
                }, to: "http://13.93.33.202:8000/api/users/me/",
                  method: .patch,
                  headers: [HTTPHeader(name: "Authorization", value: "token \(comingToken)")]
        ).validate(statusCode: acceptableStatusCodes).response { response in
            
            switch response.result {
                
            case .success(let data):
                guard let responseOBJ = try? JSONDecoder().decode(ProfileComingData.self, from: data!) else {
                    completion(.failure(CustomError(title: "Decode Error", description: "Decode Error" , code: 1)))
                    return
                }
                    completion(.success(responseOBJ))
            case .failure(let error):
                completion(.failure(CustomError(title: error.localizedDescription, description: error.localizedDescription , code: 1)))

            }
        }
    }
 
}
