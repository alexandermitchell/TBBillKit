//
//  DiscountCalculator.swift
//  
//
//  Created by Alex Mitchell on 2025-03-11.
//

import Foundation

public protocol DiscountCalculating {
    func calculateDiscountTotals(from postTaxTotal: Decimal, using discounts: Set<Discount>, order: DiscountApplicationOrder) -> (postTaxAndDiscountTotal: Decimal, discountTotal: Decimal)
}

public struct DiscountCalculator: DiscountCalculating {
    public init() {}

    private func sortDiscounts(_ discounts: Set<Discount>, by order: DiscountApplicationOrder) -> [Discount] {
        return discounts.sorted {
            switch (order, $0.type, $1.type) {
            case (.percentageFirst, .percentage, .fixedAmount): return true
            case (.fixedAmountFirst, .fixedAmount, .percentage): return true
            default: return false
            }
        }
    }
    
    public func calculateDiscountTotals(
        from postTaxTotal: Decimal,
        using discounts: Set<Discount>,
        order: DiscountApplicationOrder
    ) -> (postTaxAndDiscountTotal: Decimal, discountTotal: Decimal) {

        guard !discounts.isEmpty else {
            return (postTaxTotal, 0.0)
        }
    
        let sortedDiscounts = sortDiscounts(discounts, by: order)
        
        let rawPostTaxAndDiscountTotal = sortedDiscounts.reduce(postTaxTotal) { result, discount in
            switch discount.type {
            case .percentage(let rate):
                return result - (result * rate)
            case .fixedAmount(let amount):
                return result - amount
            }
        }
    
        let adjustedPostTaxAndDiscountTotal = max(rawPostTaxAndDiscountTotal, 0.0) // Ensure no negative total
        let discountTotal = (postTaxTotal - adjustedPostTaxAndDiscountTotal)

        return (adjustedPostTaxAndDiscountTotal, discountTotal)
    }
}
