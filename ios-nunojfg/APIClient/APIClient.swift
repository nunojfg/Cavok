//
//  APIClient.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 18/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct APIClient {
    
    func getCurrentWeather(location: CLLocation, completion: @escaping (ForecastListDTO?) -> Void) {
        
        guard var components = URLComponents(string: Service.weatherUrl) else {
            return
        }
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        components.queryItems = [URLQueryItem(name: Service.appIdParameter, value: Service.appIdValue),
                                 URLQueryItem(name: Service.unitsParameter, value: Service.unitsParameterValue),
                                 URLQueryItem(name: Service.latitudeParameter, value:latitude),
                                 URLQueryItem(name: Service.longitudeParameter, value:longitude)]
        
        guard let url = components.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data,
                let forecast = try? JSONDecoder().decode(ForecastListDTO.self, from: data) else {
                    completion(nil)
                    return
            }
            
            completion(forecast)
        }
        
        task.resume()
    }
    
    func getForecast(location: CLLocation, completion: @escaping (ForecastDTO) -> Void) {
        
        guard var components = URLComponents(string: Service.baseUrl) else {
            return
        }
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        components.queryItems = [URLQueryItem(name: Service.appIdParameter, value: Service.appIdValue),
                                 URLQueryItem(name: Service.unitsParameter, value: Service.unitsParameterValue),
                                 URLQueryItem(name: Service.latitudeParameter, value:latitude),
                                 URLQueryItem(name: Service.longitudeParameter, value:longitude)]
        
        guard let url = components.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data,
                let forecast = try? JSONDecoder().decode(ForecastDTO.self, from: data) else {
                    completion(ForecastDTO())
                    return
            }
            
            completion(forecast)
        }
        
        task.resume()
        
    }
    
    static func getWeatherIconURL(iconValue: String) -> URL? {
        
        let urlStr = "\(Service.weatherIconBaseUrl)\(String(describing: iconValue))\(Service.weatherIconEndBaseUrl)"
        return URL(string: urlStr)
    }
    
}
