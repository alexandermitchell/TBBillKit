//
//  BillCalculator.swift
//
//
//  Created by Alex Mitchell on 2025-03-10.
//

import Foundation

public protocol BillCalculating {
    func calculateBill(for items: [ItemCategory: OrderedSet<BillItem>], taxes: Set<Tax>, discounts: Set<Discount>, discountOrder: DiscountApplicationOrder) -> (subtotal: Decimal, finalTotal: Decimal, taxTotal: Decimal, discountTotal: Decimal)
}

public class BillCalculator: BillCalculating {
    private let taxCalculator: TaxCalculating
    private let discountCalculator: DiscountCalculating
    
    public init(taxCalculator: TaxCalculating, discountCalculator: DiscountCalculating) {
        self.taxCalculator = taxCalculator
        self.discountCalculator = discountCalculator
    }
    
    public func calculateBill(
        for items: [ItemCategory: OrderedSet<BillItem>],
        taxes: Set<Tax>,
        discounts: Set<Discount>,
        discountOrder: DiscountApplicationOrder
    ) -> (subtotal: Decimal, finalTotal: Decimal, taxTotal: Decimal, discountTotal: Decimal) {
        
        let (subtotal, taxTotal, postTaxTotal) = taxCalculator.calculateTaxTotals(
            for: items,
            using: taxes
        )
        
        let (finalTotal, discountTotal) = discountCalculator.calculateDiscountTotals(
            from: postTaxTotal,
            using: discounts,
            order: discountOrder
        )

        return (
            subtotal.rounded(to: 2),
            finalTotal.rounded(to: 2),
            taxTotal.rounded(to: 2),
            discountTotal.rounded(to: 2)
        )
    }
}
