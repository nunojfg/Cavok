//
//  ForecastListViewModel.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 19/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation
import UIKit

protocol ForecastListViewModelServiceProtocol {
    var items: [ForecastViewModel] { get }
    init(items: [ForecastViewModel])
    init(dtos: [ForecastListDTO])
}

struct ForecastListViewModelService: ForecastListViewModelServiceProtocol {
    var items: [ForecastViewModel] = [ForecastViewModel]()
    
    init(items: [ForecastViewModel]) {
        self.items = items
    }
    
    init(dtos: [ForecastListDTO]) {
        self.items = ForecastFactory.build(from: dtos)
    }
}

protocol ForecastListViewModelProtocol: BaseViewModel where
    Services == ForecastListViewModelService {
}

struct ForecastListViewModel: ForecastListViewModelProtocol {
    typealias Services = ForecastListViewModelService
    var values: Services
    init(withServices services: Services) {
        self.values = services
    }
}
