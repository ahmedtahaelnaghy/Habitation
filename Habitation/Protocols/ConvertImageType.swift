//
//  ConvertImageType.swift
//  Habitation
//
//  Created by Ahmed Taha on 26/06/2022.
//

import Foundation
import UIKit

extension UIImage {
    
    func convertImageToPngString(image: UIImage) -> String {
        
        guard let data = self.pngData() else {return ""}
        return data.base64EncodedString(options: .endLineWithLineFeed)
        
    }
  
}
