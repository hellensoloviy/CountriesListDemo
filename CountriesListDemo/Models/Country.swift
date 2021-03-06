//
//  Country.swift
//  CountriesListDemo
//
//  Created by Hellen Soloviy on 3/13/19.
//  Copyright © 2019 HellySolovii. All rights reserved.
//

import Foundation

class Country: Codable {
    var nativeName: String
    var borders: [String]?
    var alpha3Code: String
    var region: String
}
