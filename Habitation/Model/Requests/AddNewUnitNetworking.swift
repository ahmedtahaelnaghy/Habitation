//
//  AddNewUnitNetworking.swift
//  Habitation
//
//  Created by Ahmed Taha on 28/06/2022.
//

import Foundation
import Alamofire

enum AddNewUnitNetworking {
    case addNewUnit(model: AddNewItem, token: String)
}


extension AddNewUnitNetworking: TargetType {
    var baseURL: String {
        return "http://13.93.33.202:8000/api/ads/"
    }
    
    var pathURL: String {
        return ""
    }
    
    var method: HTTPMethod {
        switch self {
        case .addNewUnit:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .addNewUnit(let model, _):
            return .requestParameters(parameters: model.asJson() ?? [:], encoding: URLEncoding.default)
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .addNewUnit(_, _):
            
            let comingToken = UserDefaults.standard.string(forKey: "token") ?? ""
            let headers: HTTPHeaders = [
                            "Content-type": "multipart/form-data",
                            "Authorization": "token \(comingToken)"
                        ]
                        return headers
            }
     }
}
    
extension Encodable {
    
    func asJson() -> [String : Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else {
                return nil
            }
            return dictionary
        } catch {
            print("json error: \(error)")
            return nil
        }
    }
}
