//
//  ViewModelFactory.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 19/05/2019.
//  Copyright © 2019 Nuno Gonçalves. All rights reserved.
//

import Foundation

protocol ViewModelFactoryProtocol {
    associatedtype DataTransferType
    associatedtype ViewModelType
    static func build(from dto: DataTransferType) -> ViewModelType
    static func build(from list: [DataTransferType]) -> [ViewModelType]
}

extension ViewModelFactoryProtocol {
    
    static func build(from list: [DataTransferType]) -> [ViewModelType] {
        var items: [ViewModelType] = [ViewModelType]()
        for dto in list {
            let viewModel = build(from: dto)
            items.append(viewModel)
        }
        
        return items
    }
}

protocol ForecastFactoryProtocol: ViewModelFactoryProtocol {
    static func build(from dto: ForecastListDTO) -> ForecastViewModel
    static func build(from list: [ForecastListDTO]) -> [ForecastViewModel]
}

struct ForecastFactory: ForecastFactoryProtocol {
    static func build(from dto: ForecastListDTO) -> ForecastViewModel {
        let containerService = ForecastContainerService(summary: ForecastViewModelSummaryService(dto: dto),
                                                        details: ForecastViewModelWindService(dto: dto))
        return ForecastViewModel(withServices: containerService)
    }
}

protocol CityFactoryProtocol: ViewModelFactoryProtocol {
    static func build(from dto: CityDTO) -> CityViewModel
    static func build(from list: [CityDTO]) -> [CityViewModel]
}

struct CityFactory: CityFactoryProtocol {
    static func build(from dto: CityDTO) -> CityViewModel {
        let containerService = CityViewModelService(dto: dto)
        return CityViewModel(withServices: containerService)
    }
}
