//
//  CountryDetailsTableViewController.swift
//  CountriesListDemo
//
//  Created by Hellen Soloviy on 3/13/19.
//  Copyright © 2019 HellySolovii. All rights reserved.
//

import Foundation
import UIKit

class CountryDetailsTableViewController: UITableViewController {
    static let indentifier = "CountryDetailsController"
    
    //MARK: - Properties
    @IBOutlet weak var bordersLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var flagImageView: UIImageView!
    
    var country: Country! {
        didSet {
            processNewData()
        }
    }
    var bordersList: [String] = []
    
    private let defaultFlagImage = #imageLiteral(resourceName: "icon-earth-globe")


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
    private func processNewData() {
        loadAdditionalData()
    }
    
    
    private func showBordersList() {
        if bordersList.isEmpty {
            self.bordersLabel.text = "No country borders to show"
        } else {
            self.bordersLabel.text = "Country \(bordersList.count > 1 ? "borders are" : "border is") \(bordersList.joinedWithCommas)"
        }
    }
    
    private func loadAdditionalData() {
        guard let flagStringURL = country.flag else {
            flagImageView.image = defaultFlagImage
            return
        }
        
        NetworkManager().downloadImage(for: flagStringURL) { (image) in
            DispatchQueue.main.async {
                if let flag = image {
                    self.flagImageView.image = flag
                } else {
                    self.flagImageView.image = self.defaultFlagImage
                }
            }
        }
    }

}



