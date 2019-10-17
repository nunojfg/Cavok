//
//  ForecastViewModel.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 24/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation

protocol ForecastViewModelSummaryServiceProtocol {
    var temperature: Double? { get }
    var timeOfDay: Date { get }
    var weatherIconURL: URL? { get }
    var weatherIcon: String? { get }
}

struct ForecastViewModelSummaryService: ForecastViewModelSummaryServiceProtocol {
    var temperature: Double?
    var timeOfDay: Date
    var weatherIconURL: URL?
    var weatherIcon: String?
    
    init(temperature: Double, timeOfDay: Date, weatherIconURL: URL, weatherIcon: String) {
        self.temperature = temperature
        self.timeOfDay = timeOfDay
        self.weatherIconURL = weatherIconURL
        self.weatherIcon = weatherIcon
    }
    
    init(dto: ForecastListDTO) {
        self.temperature = dto.main?.temp
        self.timeOfDay = Date(timeIntervalSince1970: TimeInterval(dto.dt))
        
        guard let weatherIcon = dto.weather?.first?.icon else {
            return
        }
        
        self.weatherIcon = weatherIcon
        self.weatherIconURL = APIClient.getWeatherIconURL(iconValue: weatherIcon)
    }
}

protocol ForecastViewModelWindServiceProtocol {
    var speed: Double? { get }
    var degree: Double? { get }
}

struct ForecastViewModelWindService: ForecastViewModelWindServiceProtocol {
    var speed: Double?
    var degree: Double?
    
    init(speed: Double?, degree: Double?) {
        self.speed = speed
        self.degree = degree
    }
    
    init(dto: ForecastListDTO) {
        self.speed = dto.wind?.speed
        self.degree = dto.wind?.deg
    }
}

protocol HasForecastViewModelSummaryService {
    var summary: ForecastViewModelSummaryServiceProtocol { get }
}

protocol HasForecastViewModelWindService {
    var details: ForecastViewModelWindServiceProtocol { get }
}

protocol ForecastContainerServiceProtocol: HasForecastViewModelSummaryService,
                                           HasForecastViewModelWindService {
    var summary: ForecastViewModelSummaryServiceProtocol { get }
    var details: ForecastViewModelWindServiceProtocol { get }
}

struct ForecastContainerService: ForecastContainerServiceProtocol {
    var summary: ForecastViewModelSummaryServiceProtocol
    var details: ForecastViewModelWindServiceProtocol
}

protocol ForecastViewModelProtocol: BaseViewModel where Services == HasForecastViewModelSummaryService & HasForecastViewModelWindService {
}

extension ForecastListViewModelProtocol where Self: ForecastContainerServiceProtocol {
    
}

struct ForecastViewModel: ForecastViewModelProtocol {
    typealias Services = HasForecastViewModelSummaryService & HasForecastViewModelWindService
    var values: Services
    init(withServices services: Services) {
        self.values = services
    }
}
