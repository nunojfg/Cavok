//
//  MeasurementFormatter.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 20/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation
import UIKit

extension MeasurementFormatter {
    func toString(value: Double) -> String {
        self.numberFormatter.maximumFractionDigits = 0
        let measurement = Measurement(value: value, unit: UnitTemperature.celsius)
        let temperature = self.string(from: measurement)
        return temperature
    }
}
