//
//  SharedConstants.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 25/08/2019.
//  Copyright © 2019 Nuno Gonçalves. All rights reserved.
//

import Foundation
import UIKit

struct SharedConstants {
    
    enum Color {
        static let backgroundColor = UIColor(named: "ThemeColor")
    }
    
    enum Image {
        static let defaultWeather: UIImage =  UIImage(named: "defaultWeather")!
    }
    
    static let locale = Locale(identifier: "en")
}
