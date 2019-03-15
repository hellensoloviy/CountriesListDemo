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
        guard last != nil else { return "" }
        return String(self.joined(separator: ", ").dropLast(2))
    }
}

