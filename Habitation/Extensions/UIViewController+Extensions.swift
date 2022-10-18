//
//  UIViewCOntroller+Extensions.swift
//  Habitation
//
//  Created by Ahmed Taha on 16/10/2022.
//

import UIKit

//MARK: -> Code for textFields and buttons shape.
extension UIViewController {
        
    func editItemsShape(for items: [Any] , borderColor: UIColor, borderWidth: CGFloat, curveRadius: CGFloat, shadowColor: UIColor? = nil, shadowRadius: CGFloat? = nil, shadowOffset: CGSize? = nil, shadowOpacity: Float? = nil, masksToBounds: Bool? = nil) {
        _ = items.map {
            ($0 as AnyObject).layer.borderColor = borderColor.cgColor
            ($0 as AnyObject).layer.borderWidth = borderWidth
            ($0 as AnyObject).layer.cornerRadius = curveRadius
            ($0 as AnyObject).layer.shadowColor = shadowColor?.cgColor
            ($0 as AnyObject).layer.shadowRadius = shadowRadius ?? 0
            ($0 as AnyObject).layer.shadowOffset = shadowOffset ?? CGSize(width: 0, height: 0)
            ($0 as AnyObject).layer.shadowOpacity = shadowOpacity ?? 0.0
            ($0 as AnyObject).layer.masksToBounds = masksToBounds ?? false
        }
    }
}

//MARK: -> Showing Alert functions.
extension UIViewController {
    
    func showAlert(message: String , completion:((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: completion)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: -> Hide keyboard when tapping around the keyboard.
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: -> Update in text field.
extension UIViewController {
    
    // Method to add image in text field.
    func addImageToTextField(textField: UITextField, imageName: String, imageViewFrameX: CGFloat) {
        let image = UIImage(named: imageName)!
        let imageView = UIImageView(frame: CGRect(x: imageViewFrameX, y: 0, width: image.size.width, height: image.size.height))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: image.size.height))
        imageView.image = image
        view.addSubview(imageView)
        textField.leftView = view
        textField.leftViewMode = .always
    }
}

    // Add view as space in left text field.
    func makeLeftSpaceForTF(for array: [UITextField?]) {
        _ = array.map {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
            $0?.leftView = view
            $0?.leftViewMode = .always
        }
}

// MARK: -> Vertical Collection View design.
extension UIViewController {
    func setupVeticalCollectionViewUI(for collectionView: UICollectionView, height: CGFloat? = 0.55, leading: CGFloat? = 50, trailing: CGFloat? = 50, count: Int? = 1) {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(height!)), subitem: item, count: count!)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: leading!, bottom: 10, trailing: trailing!)
        collectionView.collectionViewLayout = layout
    }
}

// MARK: -> Horizontal Collection View design.
extension UIViewController {
    func setupHorizontalCollectionViewUI(for collectionView: UICollectionView, groupWidth: CGFloat) {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupWidth), heightDimension: .fractionalHeight(1)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
    }
}

//MARK: -> Add Button in text field
extension UIViewController {
    func addBtnToSearchTextField(textField: UITextField, action: Selector) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "search_button"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -45, bottom: 0, right: 0)
//        button.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: action, for: .touchUpInside)
        textField.rightView = button
        textField.rightViewMode = .always
         
    }
}

//MARK: -> Show and Hide the Activity Indicator.
extension UIViewController {
    
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//            activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()
        activityIndicator.tag = 100 // 100 for example
        
        // before adding it, you need to check if it is already has been added:
        for subview in view.subviews {
            if subview.tag == 100 {
                print("already added")
                return
            }
        }
        view.addSubview(activityIndicator)
    }
    
    func hideActivityIndicator() {
        let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        
        // I think you forgot to remove it?
        activityIndicator?.removeFromSuperview()
        //UIApplication.shared.endIgnoringInteractionEvents()
    }
}
