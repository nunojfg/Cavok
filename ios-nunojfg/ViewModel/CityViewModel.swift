//
//  CityViewModel.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 09/06/2019.
//  Copyright © 2019 Nuno Gonçalves. All rights reserved.
//

import Foundation

protocol CityViewModelServiceProtocol {
    var name: String { get }
    var country: String { get }
}

struct CityViewModelService: CityViewModelServiceProtocol {
    var name: String
    var country: String
    
    init(dto: CityDTO) {
        self.name = dto.name ?? ""
        self.country = SharedConstants.locale.localizedString(forRegionCode: dto.country ?? "") ?? ""
    }
}

protocol CityViewModelProtocol: BaseViewModel where
Services == CityViewModelService {
}

struct CityViewModel: CityViewModelProtocol {
    typealias Services = CityViewModelService
    var values: Services
    init(withServices services: Services) {
        self.values = services
    }
}
