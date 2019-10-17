//
//  ForecastListViewControllerSearchDataSource.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 09/06/2019.
//  Copyright © 2019 Nuno Gonçalves. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ForecastListViewControllerSearchDataSource: NSObject, DataSource {
    internal var tableView: UITableView?
    private weak var delegate: ForecastListViewSearchControllerDelegate?
    private lazy var items: [CityDTO] = {
        return cityListManager.list
    }()
    private var filteredItems: [CityDTO] = [CityDTO]()
    
    init(delegate: ForecastListViewSearchControllerDelegate, tableView: UITableView) {
        self.delegate = delegate
        self.tableView = tableView
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.separatorStyle = .none
        self.tableView?.register(UINib(nibName: CityTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.filteredItems = self.items
        }
    }
    
    func refreshData() {
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.filteredItems = self.items.filter {
                return $0.name?.lowercased().contains(searchText.lowercased()) ?? false
            }
            
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    func updateSearchResults(_ searchText: String) {
        
        filterContentForSearchText(searchText)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier,
                                                       for: indexPath ) as? CityTableViewCell else {
                                                        return UITableViewCell()
        }
        
        guard filteredItems.count > 0 else {
            return UITableViewCell()
        }
        
        let item = self.filteredItems[indexPath.row]
        let viewModel = CityFactory.build(from: item)
        
        cell.configureCell(viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.filteredItems[indexPath.row]
        
        guard let latitude = item.lat,
            let longitude = item.lng else {
                return
        }
        
        delegate?.changeLocation(item.name ?? "", location: CLLocation(latitude: CLLocationDegrees(exactly: Double(latitude) ?? 0.0) ?? 0, longitude: CLLocationDegrees(exactly: Double(longitude) ?? 0.0) ?? 0))
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


