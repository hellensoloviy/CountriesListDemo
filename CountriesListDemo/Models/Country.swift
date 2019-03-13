//
//  Country.swift
//  CountriesListDemo
//
//  Created by Hellen Soloviy on 3/13/19.
//  Copyright © 2019 HellySolovii. All rights reserved.
//

import Foundation

class Country: Codable {
    var originalName: String
    var borders: [String]?
    var alpha3Code: String
    var region: String
}
