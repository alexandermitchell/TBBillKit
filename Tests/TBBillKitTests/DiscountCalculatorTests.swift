//
//  DiscountCalculatorTests.swift
//
//
//  Created by Alex Mitchell on 2025-03-14.
//

import XCTest
@testable import TBBillKit

final class DiscountCalculatorTests: XCTestCase {
    
    var discountCalculator: DiscountCalculator!
    
    override func setUp() {
        super.setUp()
        discountCalculator = DiscountCalculator()
    }

    override func tearDown() {
        discountCalculator = nil
        super.tearDown()
    }

    func testCalculateDiscountTotals_PercentageFirst() {
        let discount1 = Discount(id: UUID(), name: "10% Off", type: .percentage(0.10))
        let discount2 = Discount(id: UUID(), name: "$5 Off", type: .fixedAmount(5.00))

        let postTaxTotal: Decimal = 100.0

        let (postTaxAndDiscountTotal, discountTotal) = discountCalculator.calculateDiscountTotals(
            from: postTaxTotal,
            using: [discount1, discount2],
            order: .percentageFirst
        )

        let expectedPostDiscountTotal = (postTaxTotal * 0.90) - 5.00  // (100 * 0.90) - 5 = 85.0
        let expectedDiscountTotal = postTaxTotal - expectedPostDiscountTotal // 100 - 85 = 15.0

        XCTAssertEqual(postTaxAndDiscountTotal, expectedPostDiscountTotal, accuracy: 0.01)
        XCTAssertEqual(discountTotal, expectedDiscountTotal, accuracy: 0.01)
    }

    func testCalculateDiscountTotals_FlatAmountFirst() {
        let discount1 = Discount(id: UUID(), name: "$5 Off", type: .fixedAmount(5.00))
        let discount2 = Discount(id: UUID(), name: "10% Off", type: .percentage(0.10))

        let postTaxTotal: Decimal = 100.0

        let (postTaxAndDiscountTotal, discountTotal) = discountCalculator.calculateDiscountTotals(
            from: postTaxTotal,
            using: [discount1, discount2],
            order: .fixedAmountFirst
        )

        let expectedPostDiscountTotal = ((postTaxTotal - 5.00) * 0.90) // (100 - 5) * 0.90 = 85.5
        let expectedDiscountTotal = postTaxTotal - expectedPostDiscountTotal // 100 - 85.5 = 14.5

        XCTAssertEqual(postTaxAndDiscountTotal, expectedPostDiscountTotal, accuracy: 0.01)
        XCTAssertEqual(discountTotal, expectedDiscountTotal, accuracy: 0.01)
    }

    func testCalculateDiscountTotals_DiscountsReduceToZero() {
        let discount1 = Discount(id: UUID(), name: "50% Off", type: .percentage(0.50))
        let discount2 = Discount(id: UUID(), name: "$50 Off", type: .fixedAmount(50.00))

        let postTaxTotal: Decimal = 100.0

        let (postTaxAndDiscountTotal, discountTotal) = discountCalculator.calculateDiscountTotals(
            from: postTaxTotal,
            using: [discount1, discount2],
            order: .percentageFirst
        )

        XCTAssertEqual(postTaxAndDiscountTotal, 0.0) // Should never go negative
        XCTAssertEqual(discountTotal, postTaxTotal) // Discounts should equal full amount
    }

    func testCalculateDiscountTotals_NoDiscounts() {
        let postTaxTotal: Decimal = 50.0

        let (postTaxAndDiscountTotal, discountTotal) = discountCalculator.calculateDiscountTotals(
            from: postTaxTotal,
            using: [],
            order: .percentageFirst
        )

        XCTAssertEqual(postTaxAndDiscountTotal, postTaxTotal)
        XCTAssertEqual(discountTotal, 0.0)
    }

    func testCalculateDiscountTotals_ExcessiveDiscount() {
        let discount = Discount(id: UUID(), name: "$200 Off", type: .fixedAmount(200.00))

        let postTaxTotal: Decimal = 50.0

        let (postTaxAndDiscountTotal, discountTotal) = discountCalculator.calculateDiscountTotals(
            from: postTaxTotal,
            using: [discount],
            order: .fixedAmountFirst
        )

        XCTAssertEqual(postTaxAndDiscountTotal, 0.0) // Should not go negative
        XCTAssertEqual(discountTotal, postTaxTotal) // Full total is discounted
    }
}

