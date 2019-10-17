//
//  ForecastListViewControllerDataSource.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 19/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ForecastListViewControllerDataSource: NSObject, DataSource {
    internal var tableView: UITableView?
    private weak var delegate: ForecastListViewControllerDelegate?
    public var items = [(key: DateComponents, value: [ForecastListDTO])]()
    private let locationManager: LocationManager = LocationManager()
    private let apiClient: APIClient = APIClient()
    let dateComponents: Set<Calendar.Component> = [.day, .month, .year]
    let calendar = Calendar.current
    
    init(delegate: ForecastListViewControllerDelegate, tableView: UITableView) {
        self.delegate = delegate
        self.tableView = tableView
        super.init()
        
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.separatorStyle = .none
        self.tableView?.register(UINib(nibName: ForecastListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ForecastListTableViewCell.reuseIdentifier)
        
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    func handleForecastList(location: CLLocation) {
        
        self.delegate?.changeLocation(location)
        
        apiClient.getCurrentWeather(location: location) { (forecastListDTO: ForecastListDTO?) in
            
            guard let forecastListDTO = forecastListDTO else {
                return
            }
            
            let viewModel = ForecastFactory.build(from: forecastListDTO)
            self.delegate?.renderPresentTemperature(temperature: MeasurementFormatter().toString(value: viewModel.values.summary.temperature ?? 0))
            self.delegate?.renderPresentTemperatureBackgroundIcon(icon: forecastListDTO.weather?.first?.icon)
        }
        
        apiClient.getForecast(location: location) { (forecastDTO: ForecastDTO) in
            self.delegate?.stopActivityProgress()
            
            guard let forecastDTOList = forecastDTO.list else {
                return
            }
            
            let dictionary = Dictionary(grouping: forecastDTOList, by: {
                self.calendar.dateComponents(self.dateComponents,
                                             from: Date(timeIntervalSince1970: TimeInterval($0.dt)))})
            
            self.items = Array(dictionary).sorted(by: {
                guard let dateFirst = self.calendar.date(from:$0.key),
                    let dateNext = self.calendar.date(from:$1.key) else {
                        return false
                }
                
                return dateFirst < dateNext
            })
            
            DispatchQueue.main.async {
                self.reloadData()
                
                guard let cityName = forecastDTO.city?.name,
                    let country = forecastDTO.city?.country else {
                        return
                }
                
                // Use the last reported location.
                
                let geocoder = CLGeocoder()
                
                let countryParsed = Locale(identifier: "en").localizedString(forRegionCode: country) ?? ""
                
                // Look up the location and pass it to the completion handler
                
                geocoder.reverseGeocodeLocation(location, preferredLocale: SharedConstants.locale, completionHandler: { placemarks, error in
                                                    
                                                    if error == nil {
                                                        
                                                        guard let city = placemarks?.first?.locality else {
                                                            
                                                            self.delegate?.renderTitle(title: "\(cityName), \(countryParsed)")
                                                            
                                                            return
                                                            
                                                        }
                                                        
                                                        self.delegate?.renderTitle(title: "\(city), \(countryParsed)")
                                                        
                                                    } else {
                                                        
                                                        // An error occurred during geocoding.
                                                        
                                                        self.delegate?.renderTitle(title: "\(cityName), \(countryParsed)")
                                                    }
                                                    
                })
            }
        }
    }
    
    func refreshData() {
        
        locationManager.requestLocation()
    }
    
    func refreshData(from location: CLLocation) {
        
        handleForecastList(location: location)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let component = self.items[section]
        guard let date = calendar.date(from: component.key) else {
            return ""
        }
        
        return DateFormatter().dateForDisplay(date: date)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 12, y: 8, width: 320, height: 30)
        myLabel.font = UIFont.boldSystemFont(ofSize: 20)
        myLabel.textColor = .white
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let headerView = UIView()
        headerView.backgroundColor = SharedConstants.Color.backgroundColor
        headerView.addSubview(myLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastListTableViewCell.reuseIdentifier,
                                                       for: indexPath ) as? ForecastListTableViewCell else {
                                                        return UITableViewCell()
        }
        
        let components = self.items[indexPath.section]
        let service = ForecastListViewModelService(dtos: components.value)
        let viewModel = ForecastListViewModel(withServices: service)

        cell.configureCell(viewModel)

        return cell
    }
}

// MARK: LocationManagerDelegate
extension ForecastListViewControllerDataSource: LocationManagerDelegate {
    func locationDidUpdate(_ service: LocationManager, location: CLLocation) {
        handleForecastList(location: location)
    }
    
    func locationDidFail(withError error: Error) {
        let alert = UIAlertController(title: "warning".localized, message: "error_retrieving_location".localized, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.delegate?.presentDialog(alert, animated: true)
        self.delegate?.stopActivityProgress()
    }
}

