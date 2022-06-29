//
//  AddNewUnitRequest.swift
//  Habitation
//
//  Created by Ahmed Taha on 28/06/2022.
//

import Foundation

class AddNewUnitRequest: BaseAPI<AddNewUnitNetworking> {
    
    func addNewUnit(model: AddNewItem, completion: @escaping(Result<AddNewItemResponseModel, Error>) -> (Void)) {
        
//        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        
        uploadMultiPartFormData(imagesData: model.images, target: .addNewUnit(model: model, token: "dabdd4b716248fcab6f17198349e100845ab9a26"), responseClass: AddNewItemResponseModel.self) { result in
            
            completion(result)
            
            
        }
        
        
        
    }
    
    
}
