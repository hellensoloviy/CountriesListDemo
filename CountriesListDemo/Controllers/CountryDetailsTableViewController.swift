//
//  CountryDetailsTableViewController.swift
//  CountriesListDemo
//
//  Created by Hellen Soloviy on 3/13/19.
//  Copyright © 2019 HellySolovii. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class CountryDetailsTableViewController: UITableViewController {
    static let indentifier = "CountryDetailsController"
    
    //MARK: - Properties
    @IBOutlet weak var bordersLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    
    var country: Country!
    var bordersList: [String] = []
    

    //MARK: - View Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameLabel.text = "Native name: \(country.nativeName)"
        showBordersList()
    }
    

    //MARK: - Private
    private func showBordersList() {
        if bordersList.isEmpty {
            self.bordersLabel.text = "No country borders to show"
        } else {
            self.bordersLabel.text = "Country \(bordersList.count > 1 ? "borders are" : "border is") \(bordersList.joinedWithCommas)"
        }
    }
    
    //MARK: - table view
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}





