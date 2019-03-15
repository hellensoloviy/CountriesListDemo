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

    @IBOutlet weak var flagView: WKWebView!
    
    var country: Country!
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
        loadAdditionalData()
    }
    

    //MARK: - Private
    private func showBordersList() {
        if bordersList.isEmpty {
            self.bordersLabel.text = "No country borders to show"
        } else {
            self.bordersLabel.text = "Country \(bordersList.count > 1 ? "borders are" : "border is") \(bordersList.joinedWithCommas)"
        }
    }
    
    private func loadAdditionalData() {
        self.flagView.contentMode = .scaleAspectFill
        
        guard let flagStringURL = country.flag, let url = URL.init(string: flagStringURL) else {
            let defaultPath = Bundle.main.path(forResource: "icon-earth-globe", ofType: "png")!
            let fileURL = URL(fileURLWithPath: defaultPath)
            let request = URLRequest(url: fileURL)
            
            self.flagView.load(request)
            return
        }
    
        let request = URLRequest(url: url)
        self.flagView.load(request)
        
    }
    
    //MARK: - table view
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {        
        return UITableView.automaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}





