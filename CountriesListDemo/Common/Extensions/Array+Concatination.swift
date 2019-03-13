//
//  Array+Concatination.swift
//  CountriesListDemo
//
//  Created by Hellen Soloviy on 3/13/19.
//  Copyright © 2019 HellySolovii. All rights reserved.
//

import Foundation

extension BidirectionalCollection where Element: StringProtocol {
   
    var joinedWithCommas: String {
        guard let last = last else { return "" }
        return dropLast().joined(separator: ",")
    }
}

//var concatinateBordersList {
//    let joiner = ":"
//    let elements = ["one", "two", "three"]
//    let joinedStrings = elements.joined(separator: joiner)
//    print("joinedStrings: \(joinedStrings)")
//}
