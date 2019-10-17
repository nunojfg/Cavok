//
//  BaseViewProtocol.swift
//  test_ios-nunojfg
//
//  Created by Nuno Gonçalves on 8/14/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewProtocol {
    func initialize()
    func setupViews()
    func setupConstraints()
    func setupObservables()
}

extension BaseViewProtocol where Self: UIView {
    
    func initialize() {
        setupViews()
        setupConstraints()
        setupObservables()
    }
}
