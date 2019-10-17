//
//  WeatherDTO.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 18/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation

struct WeatherDTO: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}
