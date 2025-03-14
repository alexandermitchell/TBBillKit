//
//  Decimal+Rounded.swift
//
//
//  Created by Alex Mitchell on 2025-03-10.
//

import Foundation

public extension Decimal {
    /// Helper function to uniformaly round decimals and ensure accuracy
    func rounded(to places: Int) -> Decimal {
        let behavior = NSDecimalNumberHandler(
            roundingMode: .bankers,
            scale: Int16(places),
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: false
        )
        return NSDecimalNumber(decimal: self).rounding(accordingToBehavior: behavior).decimalValue
    }
}
