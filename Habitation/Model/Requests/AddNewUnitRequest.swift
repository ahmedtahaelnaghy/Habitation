//
//  AddNewUnitRequest.swift
//  Habitation
//
//  Created by Ahmed Taha on 28/06/2022.
//

import Foundation

class AddNewUnitRequest: BaseAPI<AddNewUnitNetworking> {
    
    func addNewUnit(model: AddNewItem, completion: @escaping(Result<AddNewItemResponseModel, Error>) -> (Void)) {
        
        let comingToken = UserDefaults.standard.string(forKey: "token") ?? ""
        
        uploadMultiPartFormData(imagesData: model.images, target: .addNewUnit(model: model, token: comingToken), responseClass: AddNewItemResponseModel.self) { result in
            
            completion(result)
        }
    }
}
