//
//  Double+Ext.swift
//  Coop App
//
//  Created by John Gabriel on 24/11/2026.
//

import Foundation

extension Double {
    func currencyString() -> String {
        return formatted(.number.precision(.fractionLength(2)))
    }
}
