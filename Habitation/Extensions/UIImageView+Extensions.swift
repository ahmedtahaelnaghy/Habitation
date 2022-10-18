//
//  UIImageView+Extensions.swift
//  Habitation
//
//  Created by Ahmed Taha on 16/10/2022.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func setImage(for linkString: String?, placeholder: UIImage? = UIImage(systemName: "exclamationmark.triangle.fill")) {
        guard let linkString = linkString,
              let url = URL(string: "http://13.93.33.202:8000\(linkString)") else { return }
        sd_setImage(with: url, placeholderImage: placeholder)
    }
}
