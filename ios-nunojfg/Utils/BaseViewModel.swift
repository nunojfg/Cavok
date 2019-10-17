//
//  BaseViewModel.swift
//  test_ios-nunojfg
//
//  Created by Nuno Gonçalves on 15/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation

protocol BaseViewModel {
    associatedtype Services
    init (withServices services: Services)
    var values: Services { get }
}
