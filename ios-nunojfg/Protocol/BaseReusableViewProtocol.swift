//
//  BaseReusableViewProtocol.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 22/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation
import UIKit

protocol BaseReusableViewProtocol {
    static var reuseIdentifier: String { get }
}

extension BaseReusableViewProtocol where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
