//
//  ForecastDTO.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 18/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation

struct ForecastDTO: Codable {
    var cod: String?
    var message: Double?
    var cnt: Int?
    var list: [ForecastListDTO]?
    var city: CityDTO?
}
