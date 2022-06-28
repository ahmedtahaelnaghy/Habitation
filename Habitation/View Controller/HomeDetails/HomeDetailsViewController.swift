//
//  HomeDetailsViewController.swift
//  Habitation
//
//  Created by Ahmed Taha on 21/06/2022.
//

import UIKit

class HomeDetailsViewController: UIViewController {
    
    @IBOutlet weak var homeDetailsTableView: UITableView!

    
    var tableViewCell: AllDetailsTableViewCell!
    
    var imagesArray = ["", "", "", "", "", "","","","",""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewCell = AllDetailsTableViewCell()
        
        homeDetailsTableView.delegate = self
        homeDetailsTableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
                
    }
    
    
}

// tableView data
extension HomeDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        
        switch indexPath.row {
            
        case 0:
            
            let firstCell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! AllDetailsTableViewCell

            return firstCell
            
        case 1:
            let secondCell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! AllDetailsTableViewCell
            
            return secondCell
            
        case 2:
            
            let thirdCell = tableView.dequeueReusableCell(withIdentifier: "thirdCell", for: indexPath) as! AllDetailsTableViewCell
            
            return thirdCell
            
        default:
            
            let fourthCell = tableView.dequeueReusableCell(withIdentifier: "fourthCell", for: indexPath)
            
            return fourthCell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0 :
            return 300
        case 1:
            return 125
        case 2:
            return 50
            
        default:
            return 500
            
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
}
