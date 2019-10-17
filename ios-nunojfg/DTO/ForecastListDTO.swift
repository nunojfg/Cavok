//
//  ForecastListDTO.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 19/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation

struct ForecastListDTO: Codable {
    var dt: Int64
    var main: TemperatureDTO?
    var weather: [WeatherDTO]?
    var clouds: CloudsDTO?
    var wind: WindDTO?
}
