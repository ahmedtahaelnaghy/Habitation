//
//  BaseAPI.swift
//  Habitation
//
//  Created by Ahmed Taha on 28/06/2022.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    
    var acceptableStatusCodes = [] + (200..<300).reversed() + (400..<500).reversed()
    
    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding){
            switch task {
            case .requestPlain:
                return ([:], URLEncoding.default)
            case .requestParameters(parameters: let parameters, encoding: let encoding):
                return (parameters, encoding)
            }
        }
    
    
    func uploadMultiPartFormData<M: Codable>(imagesData:[Data],target: T, responseClass: M.Type, completion: @escaping(Result<M,Error>)-> Void) {
            
            let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
            let headers = target.headers
            let params = buildParams(task: target.task)
            let url = target.baseURL + target.pathURL
            
            let imageParamName = "images[]"
            print(url)
            AF.upload(multipartFormData: { multipartFormData in
                        // import image to request
                for imageData in imagesData {
                            multipartFormData.append(imageData, withName: "\(imageParamName)", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
                for (key, value) in params.0 {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                
                }
                    }, to: url,
                      method: method,
                      headers: headers
            ).validate(statusCode: acceptableStatusCodes).response { response in
                print(response.result)
                switch response.result {
                    
                case .success(let data):
                    guard let responseOBJ = try? JSONDecoder().decode(M.self, from: data!) else {
                        completion(.failure(CustomError(title: "Decode Error", description: "Decode Error" , code: 1)))
                        return
                    }
                    print(response.response?.statusCode)
                    if response.response?.statusCode == 200 {
                        completion(.success(responseOBJ))
                    } else {
                        
//                        completion(.failure(CustomError(title: "State code error", description: "State code error" , code: 1)))
//                            return
                        
                        completion(.failure(CustomError(title: "State code error", description: "State code error" , code: 1)))

                    }
                case .failure(let error):
                    completion(.failure(CustomError(title: error.localizedDescription, description: error.localizedDescription , code: 1)))

                }
            }
        }
    
}
