//
//  TaxCalculator.swift
//
//
//  Created by Alex Mitchell on 2025-03-10.
//

import Foundation

public protocol TaxCalculating {
    func calculateTaxTotals(for billItems: [ItemCategory: OrderedSet<BillItem>], using taxes: Set<Tax>) -> (subtotal: Decimal, taxTotal: Decimal, postTaxTotal: Decimal)
}

public struct TaxCalculator: TaxCalculating {
    public init() {}

    public func calculateTaxTotals(for billItems: [ItemCategory: OrderedSet<BillItem>], using taxes: Set<Tax>) -> (subtotal: Decimal, taxTotal: Decimal, postTaxTotal: Decimal) {
        var subtotal: Decimal = 0.0
        var taxTotal: Decimal = 0.0

        for (_, items) in billItems {
            for item in items {
                let itemTotal = item.price * Decimal(item.quantity)
                subtotal += itemTotal

                for tax in taxes where tax.applicableCategories.contains(item.category) {
                    if item.exemptTaxes.contains(tax.id) { continue }
                    taxTotal += itemTotal * tax.rate
                }
            }
        }

        let postTaxTotal = (subtotal + taxTotal)
        return (subtotal, taxTotal, postTaxTotal)
    }
}
