//
//  BillCalculatorTests.swift
//
//
//  Created by Alex Mitchell on 2025-03-11.
//

import XCTest
@testable import TBBillKit

final class BillCalculatorTests: XCTestCase {
    
    var billCalculator: BillCalculator!
    var mockTaxCalculator: MockTaxCalculator!
    var mockDiscountCalculator: MockDiscountCalculator!
    
    override func setUp() {
        super.setUp()
        mockTaxCalculator = MockTaxCalculator()
        mockDiscountCalculator = MockDiscountCalculator()
        billCalculator = BillCalculator(taxCalculator: mockTaxCalculator, discountCalculator: mockDiscountCalculator)
    }

    override func tearDown() {
        super.tearDown()
        billCalculator = nil
        mockTaxCalculator = nil
        mockDiscountCalculator = nil
    }
    
    func testCalculateBillReceivesCalculatorValues() {
        let billItems: [ItemCategory: OrderedSet<BillItem>] = [
            .food: [BillItem(id: UUID(), name: "Burger", category: .food, price: 10.00)]
        ]

        mockTaxCalculator.subtotal = 10.0
        mockTaxCalculator.taxTotal = 5.0
        mockDiscountCalculator.postTaxAndDiscountTotal = 12.00
        mockDiscountCalculator.discountTotal = 3.00

        let (subtotal, finalTotal, taxTotal, discountTotal) = billCalculator.calculateBill(for: billItems, taxes: [], discounts: [], discountOrder: .percentageFirst)

        XCTAssertEqual(subtotal, 10.00)
        XCTAssertEqual(taxTotal, 5.00)
        XCTAssertEqual(discountTotal, 3.00)
        XCTAssertEqual(finalTotal, 12.00)
    }
}


// MARK: - Mock TaxCalculator
final class MockTaxCalculator: TaxCalculating {
    var subtotal: Decimal = 0.0
    var taxTotal: Decimal = 0.0
    var postTaxTotal: Decimal = 0.0
    
    func calculateTaxTotals(for billItems: [ItemCategory: OrderedSet<BillItem>], using taxes: Set<Tax>) -> (subtotal: Decimal, taxTotal: Decimal, postTaxTotal: Decimal) {
        return (subtotal, taxTotal, postTaxTotal)
    }
}

// MARK: - Mock DiscountCalculator
final class MockDiscountCalculator: DiscountCalculating {
    var postTaxAndDiscountTotal: Decimal = 0.0
    var discountTotal: Decimal = 0.0

    func calculateDiscountTotals(from postTaxTotal: Decimal, using discounts: Set<Discount>, order: DiscountApplicationOrder) -> (postTaxAndDiscountTotal: Decimal, discountTotal: Decimal) {
        return (postTaxAndDiscountTotal, discountTotal)
    }
}




