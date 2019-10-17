//
//  File.swift
//  test_ios-nunojfg
//
//  Created by Nuno Gonçalves on 15/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation
import UIKit

protocol DataSource: UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView? { get set }
    func reloadData()
}

extension DataSource where Self: NSObject {
    
    func reloadData() {
        guard let tableView = self.tableView else {
            return
        }
        
        tableView.reloadData()
    }
}
