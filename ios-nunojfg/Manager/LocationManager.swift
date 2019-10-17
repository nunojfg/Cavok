//
//  LocationManager.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 25/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func locationDidUpdate(_ service: LocationManager, location: CLLocation)
    func locationDidFail(withError error: Error)
}

class LocationManager: NSObject {
    var delegate: LocationManagerDelegate?
    
    fileprivate let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

// MARK: - CLLocationManager Delegate
extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Current location: \(location)")
            delegate?.locationDidUpdate(self, location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationDidFail(withError: error)
        locationManager.stopUpdatingLocation()
        print("Error finding location: \(error.localizedDescription)")
    }
}
