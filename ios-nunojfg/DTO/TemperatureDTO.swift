//
//  TemperatureDTO.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 19/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation

struct TemperatureDTO: Codable {
    var temp: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Double?
    var sea_level: Double?
    var grnd_level: Double?
    var humidity: Int?
}
