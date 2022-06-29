//
//  AddNewItemViewModel.swift
//  Habitation
//
//  Created by Ahmed Taha on 27/06/2022.
//

import Foundation
import  UIKit

struct AddNewItemViewModel: AddNewItemViewModelProtocol {
    var name: String
    var description: String
    var price: Double
    var cashDiscount: Double
    var type: String
    var area: Int
    var bathsNo: Int
    var bedRoomsNo: Int
    var location: [Int]
    var images: [UIImage]
    var available: Bool
    var diriction: String
    
    mutating func SetNewItemImage(images: [UIImage]){
        self.images = images
    }
    
}

protocol AddNewItemViewModelProtocol {
    var name: String {get}
    var description: String {get}
    var price: Double {get}
    var cashDiscount: Double {get}
    var type: String {get}
    var area: Int {get}
    var bathsNo: Int {get}
    var bedRoomsNo: Int {get}
    var location: [Int] {get}
    var images: [UIImage] {get}
    var available: Bool {get}
    var diriction: String {get}
    
    mutating func SetNewItemImage(images: [UIImage])
}
