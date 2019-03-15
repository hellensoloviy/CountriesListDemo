//
//  NetworkManager.swift
//  CountriesListDemo
//
//  Created by Hellen Soloviy on 3/13/19.
//  Copyright © 2019 HellySolovii. All rights reserved.
//

import Foundation
import UIKit

enum Endpoints: String {
    case allCountries = "all"
}

protocol NetworkManagerDelegate: class {
    func dataLoadDidStart(for request: URL)
    func dataLoadDidEnd(for request: URL)
}

class NetworkManager {
    //MARK: - Properties
    weak var delegate: NetworkManagerDelegate?
    private let baseURlString = "https://restcountries.eu/rest/v2/"
    
    func fetchAllCountriesList(completion: @escaping ([Country]?) -> Void) {
        let fullUrlString = baseURlString + Endpoints.allCountries.rawValue
        
        guard let url = URL(string: fullUrlString) else {
            completion(nil)
            return
        }
        
        //Config request
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .returnCacheDataElseLoad,
                                    timeoutInterval: 10.0 * 1000)
        
        //set method type and headers
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        delegate?.dataLoadDidStart(for: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) -> Void in
            self.delegate?.dataLoadDidEnd(for: url)

            guard error == nil else {
                print("Error while fetching remote rooms: \(String(describing: error))")
                completion(nil)
                return
            }
            
            //Check if there is data which can be encoded
            guard let data = data else {
                print("Nil data received from request \(url)")
                    completion(nil)
                    return
            }
        
            //Try to encode data to models objects
            do {
                let decoder = JSONDecoder()
                let models = try decoder.decode(Array<Country>.self, from: data)
                completion(models)
            } catch let error {
                print("Error occured!", error)
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    
}

