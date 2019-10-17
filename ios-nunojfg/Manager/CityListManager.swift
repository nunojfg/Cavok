//
//  CityListManager.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 10/06/2019.
//  Copyright © 2019 Nuno Gonçalves. All rights reserved.
//

import Foundation

struct CityListManager {
    
    lazy var list: [CityDTO] = {
        
        if let url = Bundle.main.url(forResource: "city.list", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([CityDTO].self, from: data)
                return jsonData//.sorted { $0.name ?? "" < $1.name ?? "" }
            } catch {
                return []
            }
        }
        return []
    }()
}
