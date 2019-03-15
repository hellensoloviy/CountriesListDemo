//
//  CountriesListViewController.swift
//  CountriesListDemo
//
//  Created by Hellen Soloviy on 3/13/19.
//  Copyright © 2019 HellySolovii. All rights reserved.
//

import Foundation
import UIKit

class CountriesListViewController: UIViewController {
    static let identifier = "CountriesListViewController"
    

    // MARK: - Properties
    @IBOutlet var tableView: UITableView!

    let searchController = UISearchController(searchResultsController: nil)
    
    //all countries
    var countries: [Country] = [] {
        didSet{
            //This is done because of not main thread possibiity. UI related methods must be called only from main thread and this will garantee this.
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //countries after search
    var filteredCountries: [Country] = []  {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    //MARK: - private vars
    private let detailsSegueIdentifier = "showCountryDetailsSegue"

    
    // MARK: - View LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        
        NetworkManager().fetchAllCountriesList { (countriesFromRequest) in
            self.countries = countriesFromRequest ?? []
        }
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectionIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailsSegueIdentifier, let vc = segue.destination as? CountryDetailsTableViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let country: Country
                if isFiltering() {
                    country = filteredCountries[indexPath.row]
                } else {
                    country = countries[indexPath.row]
                }

                vc.country = country
                vc.bordersList = self.processBordersList(for: country)

                vc.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    //MARK: - Private
    private func setupSearchController() {
        // General Setup of the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //Set current controller as a delegate
        searchController.searchBar.delegate = self
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCountries = countries.filter({( country : Country) -> Bool in
            if isSearchBarEmpty {
                return true
            } else {
                return country.nativeName.lowercased().contains(searchText.lowercased())
            }
        })
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private func country(for index: Int) -> Country {
        if isFiltering() {
            return filteredCountries[index]
        } else {
            return countries[index]
        }
    }
    
    private func processBordersList(for country: Country) -> [String] {
        if let borders = country.borders {
            print("Country borders codes = \(borders)")
            let bordersCountries = countries.filter { borders.contains($0.alpha3Code) }
            let bordersFullNames = bordersCountries.map { $0.nativeName }
            print("Country borders names = \(bordersFullNames)")
            return bordersFullNames
        } else {
            return []
        }
    }
    
}

//MARK: - Search Controller Delegate
extension CountriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredCountries.count : countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = country(for: indexPath.row)
        
        cell.textLabel!.text = object.nativeName
        cell.detailTextLabel!.text = object.region
        return cell
    }
    
}

//MARK: - Search Controller Delegate
extension CountriesListViewController: UITableViewDelegate {

}

//MARK: - Search Bar Delegate
extension CountriesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

//MARK: - Search Results Updating
extension CountriesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
}
