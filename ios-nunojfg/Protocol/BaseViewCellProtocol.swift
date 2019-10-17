//
//  BaseViewCellProtocol.swift
//  test_ios-nunojfg
//
//  Created by Nuno Gonçalves on 8/14/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewCellProtocol: BaseReusableViewProtocol {
    associatedtype ViewModelType
    func initialize()
    func setupViews()
    func setupConstraints()
    func setupObservables()
    func configureCell(_ viewModel: ViewModelType)
}

extension BaseViewCellProtocol where Self: UIView {
    
    func initialize() {
        setupViews()
        setupConstraints()
        setupObservables()
    }
    
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupObservables() {
        
    }
}
