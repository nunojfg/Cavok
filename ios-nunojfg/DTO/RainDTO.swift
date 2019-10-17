//
//  RainDTO.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 19/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation

struct RainDTO: Codable {
    var precipitation: Int
    
    public enum UserResponseKeys: String, CodingKey{
        case precipitation = "3h"
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: UserResponseKeys.self)
        
        if let precipitation = try container.decodeIfPresent(Int.self, forKey: .precipitation) {
            self.precipitation = precipitation
        } else {
            self.precipitation = 0
        }
    }
}
