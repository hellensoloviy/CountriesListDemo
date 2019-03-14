//
//  CountryDetailsController.swift
//  CountriesListDemo
//
//  Created by Hellen Soloviy on 3/13/19.
//  Copyright © 2019 HellySolovii. All rights reserved.
//

import Foundation
import UIKit

class CountryDetailsController: UIViewController {
    static let indentifier = "CountryDetailsController"
    
    //MARK: - Properties
    @IBOutlet weak var bordersLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    var country: Country!
    var bordersList: [String] = []
    
    private let defaultFlagImage = #imageLiteral(resourceName: "icon-earth-globe")


    //MARK: - View Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = country.nativeName
        self.bordersLabel.text = bordersList.joinedWithCommas
    }
    
    func loadAdditionalData() {
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

//
////MARK: - TableView DataSource
//extension CountryDetailsController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//
//        cell.textLabel!.text =
//        cell.detailTextLabel!.text = candy.category
//
//        return cell
//    }
//
//}
//
////MARK: - TableView Delegate
//extension CountryDetailsController: UITableViewDelegate {
//
//}


