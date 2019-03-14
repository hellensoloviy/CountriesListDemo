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

    
    //MARK: - Public Functions
    func downloadImage(for string: String, completion: @escaping (UIImage?) -> Void) {
        guard let catPictureURL = URL(string: string) else {
            print("image URL-string is not correct: \(string)")
            completion(nil)
            return
        }
        
        let downloadPicTask = URLSession.shared.dataTask(with: catPictureURL) { (data, response, error) in
            if let error = error {
                print("Error downloading cat picture: \(error)")
                completion(nil)
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    if let imageData = data {
                        // Convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)
                        completion(image)
                    } else {
                        print("Couldn't get image: Image is nil")
                        completion(nil)
                    }
                } else {
                    print("Couldn't get response code for some reason")
                    completion(nil)
                }
            }
        }
        
        downloadPicTask.resume()
    }
    
    
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

