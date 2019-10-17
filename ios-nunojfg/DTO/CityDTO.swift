//
//  CityDTO.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 19/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation

struct CityDTO: Codable {
    var id: Int?
    var name: String?
    var country: String?
    var lat: String?
    var lng: String?
    var population: Int64?
}
