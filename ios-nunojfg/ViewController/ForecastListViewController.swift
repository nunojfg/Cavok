//
//  ForecastListViewController.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 19/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import UIKit
import CoreLocation

protocol ForecastListViewControllerDelegate: class {
    
    func stopActivityProgress()
    func renderTitle(title: String)
    func renderPresentTemperature(temperature: String)
    func renderPresentTemperatureIcon(iconURL: URL?)
    func renderPresentTemperatureBackgroundIcon(icon: String?)
    func presentDialog(_ alert: UIAlertController, animated: Bool)
    func changeLocation(_ name: String, location: CLLocation)
    func changeLocation(_ location: CLLocation)
}

protocol ForecastListViewSearchControllerDelegate: ForecastListViewControllerDelegate {
    
    func isFiltering() -> Bool
}

class ForecastListViewController: BaseViewController, ForecastListViewControllerDelegate {
   
    @IBOutlet var presentTemperatureImageView: UIImageView!
    @IBOutlet var presentTemperatureLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchTableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    private var dataSource: ForecastListViewControllerDataSource?
    private var searchDataSource: ForecastListViewControllerSearchDataSource?
    private var location: CLLocation?
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTableView.isHidden = true
        self.view.backgroundColor = SharedConstants.Color.backgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        
        self.tableView.addSubview(refreshControl)
        self.tableView.backgroundColor = SharedConstants.Color.backgroundColor
        self.searchTableView.backgroundColor = SharedConstants.Color.backgroundColor
        
        self.activityIndicatorView.startAnimating()
        self.activityIndicatorView.hidesWhenStopped = true
        
        self.dataSource = ForecastListViewControllerDataSource(delegate:self, tableView: tableView)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        self.searchDataSource = ForecastListViewControllerSearchDataSource(delegate: self, tableView: searchTableView)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "search_placeholder".localized
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.barTintColor = SharedConstants.Color.backgroundColor
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .refresh,
                            target: self, action: #selector(refreshDataFromSavedLocation)),
            UIBarButtonItem(image: UIImage(named: "locationIcon"),
                            style: .plain, target: self, action: #selector(refreshData))]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarAction))
        definesPresentationContext = true
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationBar?.shadowImage = UIImage()
        navigationBar?.barTintColor = SharedConstants.Color.backgroundColor
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func renderTitle(title: String) {
        self.title = title
    }
    
    func renderPresentTemperature(temperature: String) {
        DispatchQueue.main.async {
            self.presentTemperatureLabel.text = temperature
        }
    }
    
    func renderPresentTemperatureIcon(iconURL: URL?) {
        
        guard let iconURL = iconURL else {
            return
        }
        
        DispatchQueue.main.async {
            self.presentTemperatureImageView.load(url: iconURL, placeholder: SharedConstants.Image.defaultWeather)
        }
    }
    
    func renderPresentTemperatureBackgroundIcon(icon: String?) {
        
        guard let icon = icon else {
            return
        }

        DispatchQueue.main.async {
            self.presentTemperatureImageView.image = UIImage(named: icon)
        }
    }
    
    @objc func searchBarAction() {
        
        tableView?.tableHeaderView = self.searchController.searchBar
        tableView?.tableHeaderView?.backgroundColor = .white
        
        if #available(iOS 11, *) {
            //iOS 11+ code here.
        } else { // To fix search being broken in iOS10
            tableView?.contentOffset = CGPoint(x: 0, y: -5)
        }
        
        searchController.searchBar.becomeFirstResponder()
    }
    
    @objc func refreshData() {
        self.dataSource?.refreshData()
        refreshControl.endRefreshing()
    }
    
    @objc func refreshDataFromSavedLocation() {
        
        guard let location = self.location else {
            return
        }
        
        self.dataSource?.refreshData(from: location)
    }
    
    func stopActivityProgress() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func presentDialog(_ alert: UIAlertController, animated: Bool) {
        self.present(alert, animated: animated, completion: nil)
    }
    
    func changeLocation(_ name: String, location: CLLocation) {
        
        self.location = location
        renderTitle(title: name)
        DispatchQueue.main.async {
            self.searchTableView.isHidden = true
        }
        searchController.isActive = false
        
        self.dataSource?.handleForecastList(location: location)
    }
    
    func changeLocation(_ location: CLLocation) {
        self.location = location
    }
}

extension ForecastListViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        
        if !searchController.isActive {
            
            self.tableView?.tableHeaderView = nil
            searchTableView.isHidden = true
        }
            
        else {
            searchTableView.isHidden = false
            searchDataSource?.updateSearchResults(searchController.searchBar.text!)
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
}

extension ForecastListViewController: ForecastListViewSearchControllerDelegate {
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension ForecastListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        DispatchQueue.main.async {
            self.searchTableView.isHidden = true
        }
    }
}
