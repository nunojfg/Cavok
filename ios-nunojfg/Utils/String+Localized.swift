//
//  String+Localized.swift
//  test_ios-nunojfg
//
//  Created by Nuno Gonçalves on 8/13/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    func localized(withComment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: withComment)
    }
}
