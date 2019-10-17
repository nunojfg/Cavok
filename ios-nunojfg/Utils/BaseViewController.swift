//
//  BaseViewController.swift
//  test_ios-nunojfg
//
//  Created by Nuno Gonçalves on 8/14/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BaseViewProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
