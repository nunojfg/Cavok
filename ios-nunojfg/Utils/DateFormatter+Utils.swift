//
//  Date+Utils.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 20/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    func timeOfDay(date: Date) -> String {
        self.dateFormat = "H a"
        let timeOfDayFormatted = self.string(from: date)
        return timeOfDayFormatted
    }
    
    func dateForDisplay(date: Date) -> String {
        self.dateFormat = "EEEE"
        let dateForDisplayFormatted = self.string(from: date)
        return dateForDisplayFormatted
    }
}
