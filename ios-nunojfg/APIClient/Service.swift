//
//  Service.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 18/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation

enum Units {
    
    case fahenreit
    case celsius
    case kelvin
    
    var value: String {
        switch self {
        case .fahenreit:
            return "imperial"
        case .celsius:
            return "metric"
        case .kelvin:
            return ""
        }
    }
}

struct Service {
    static let baseUrl: String = "https://api.openweathermap.org/data/2.5/forecast"
    static let weatherUrl: String = "https://api.openweathermap.org/data/2.5/weather"
    static let weatherIconBaseUrl: String = "https://openweathermap.org/img/w/"
    static let weatherIconEndBaseUrl: String = ".png"
    static let queryParameter: String = "q"
    static let queryParameterValue: String = "London,uk"
    static let appIdParameter: String = "appid"
    static let appIdValue: String = "294d9d8f1ba55e70ae4078c8f6bc420a"
    static let unitsParameter: String = "units"
    static let unitsParameterValue: String = Units.celsius.value
    static let latitudeParameter: String = "lat"
    static let longitudeParameter: String = "lon"
}
