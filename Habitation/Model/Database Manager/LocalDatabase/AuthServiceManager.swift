//
//  AuthServiceManager.swift
//  Habitation
//
//  Created by Ahmed Taha on 22/06/2022.
//

import Foundation
import Alamofire
import CloudKit

class AuthServiceManager {
    
    // function that post login
    func fetchAuthDataFromAlamofire(email: String, password: String, completion: @escaping(Result<Model, Error>) -> (Void)) {
        
        let parameters = [
                          "email": email,
                          "password": password
                          ]
        
        guard let url = URL(string: "http://13.93.33.202:8000/auth/token/login/") else {return}
        
        let request = AF.request(url, method: .post, parameters: parameters , encoding: JSONEncoding.default)
        
        request.response { dataResponse in
            
            switch dataResponse.result {
                
            case .success(let data):
                
                if dataResponse.response!.statusCode > 299 {
                    completion(.failure(CustomError(title: "", description: "Your email or password incorrect", code: 100)))
                    return
                }
                
                guard let model = try? JSONDecoder().decode(Model.self, from: data!) else {return}
                
                let userDefaults = UserDefaults.standard
                userDefaults.set(model.auth_token, forKey: "token")
                
                completion(.success(model))
                
            case .failure(let error):
                                
                print(error.localizedDescription)
            }
        }
    }
    
    // function that post SignUp and save name in userDefaults
    func addNewAcountInAlamofire(name: String, email: String, password: String, verifyPassword: String, completion: @escaping (Result<SignUpInfo, Error>) -> (Void)) {
        
        let parameters = [
                          "name": name,
                          "email": email,
                          "password": password,
                          "re_password": verifyPassword
                          ]
        
        guard let url = URL(string: "http://13.93.33.202:8000/auth/users/") else {return}
        
        let request = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        request.response { (dataResponse) in
            
            switch dataResponse.result {
                
            case .success(let data):
                
                if dataResponse.response!.statusCode > 299 {
                    
                    completion(.failure(CustomError(title: "", description: "Your email or password incorrect", code: 100)))
                    
                    return
                }
                
                guard let signUpModel = try? JSONDecoder().decode(SignUpInfo.self, from: data!) else {return}
                
                let userDefaults = UserDefaults.standard
                
                userDefaults.set(signUpModel.name, forKey: "name")
                userDefaults.set(signUpModel.email, forKey: "email")
                
                completion(.success(signUpModel))
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // function that get token and save name in userDefaults
    func tokenData(completion: @escaping (Result<SignUpInfo, Error>) -> (Void)) {
        
        let userDefaults = UserDefaults.standard
        guard let comingToken = userDefaults.string(forKey: "token") else {return}
        guard let url = URL(string: "http://13.93.33.202:8000/auth/users/me/") else {return}
        
        let request = AF.request(url, method: .get, headers: [HTTPHeader(name: "Authorization", value: "token \(comingToken)")])
                
        request.response { dataResponse in

            switch dataResponse.result {

            case .success(let data):

                guard let comingData = try? JSONDecoder().decode(SignUpInfo.self, from: data!) else {return}
                                                
                userDefaults.set(comingData.name, forKey: "name")
                userDefaults.set(comingData.email, forKey: "email")
                
                completion(.success(comingData))

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

protocol OurErrorProtocol: LocalizedError {

    var title: String? { get }
    var code: Int { get }
}


struct CustomError: OurErrorProtocol {

    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
        
    }
}
