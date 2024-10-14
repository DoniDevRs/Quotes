//
//  String+Ext.swift
//  QuotesApp
//
//  Created by Doni Silva on 27/08/24.
//

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
