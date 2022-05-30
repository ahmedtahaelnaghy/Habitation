//
//  TabBarViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 30/05/2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        SimpleAnnimationWhenSelectItem(item)
        
    }
    
    func SimpleAnnimationWhenSelectItem(_ item: UITabBarItem){
        
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }

        let timeInterval: TimeInterval = 0.3
        
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            
        }
        
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        
        propertyAnimator.startAnimation()
        
    }
    
}
