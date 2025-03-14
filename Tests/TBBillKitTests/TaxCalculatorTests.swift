//
//  TaxCalculatorTests.swift
//
//
//  Created by Alex Mitchell on 2025-03-13.
//

import XCTest
@testable import TBBillKit

final class TaxCalculatorTests: XCTestCase {
    
    var taxCalculator: TaxCalculator!
    
    override func setUp() {
        super.setUp()
        taxCalculator = TaxCalculator()
    }

    override func tearDown() {
        taxCalculator = nil
        super.tearDown()
    }

    func testCalculateTaxTotals_WithValidTaxes() {
        let tax1 = Tax(id: UUID(), name: "Sales Tax", rate: 0.10, applicableCategories: [.food])
        let tax2 = Tax(id: UUID(), name: "Luxury Tax", rate: 0.05, applicableCategories: [.beverage])

        let billItems: [ItemCategory: OrderedSet<BillItem>] = [
            .food: [BillItem(id: UUID(), name: "Pizza", category: .food, price: 20.0, quantity: 1)],
            .beverage: [BillItem(id: UUID(), name: "Wine", category: .beverage, price: 50.0, quantity: 1)]
        ]

        let (subtotal, taxTotal, postTaxTotal) = taxCalculator.calculateTaxTotals(for: billItems, using: [tax1, tax2])

        XCTAssertEqual(subtotal, 70.0)
        XCTAssertEqual(taxTotal, (20.0 * 0.10) + (50.0 * 0.05), accuracy: 0.01)
        XCTAssertEqual(postTaxTotal, subtotal + taxTotal, accuracy: 0.01)
    }

    func testCalculateTaxTotals_WithExemptTaxes() {
        let tax1 = Tax(id: UUID(), name: "Sales Tax", rate: 0.10, applicableCategories: [.food])
        let tax2 = Tax(id: UUID(), name: "Luxury Tax", rate: 0.05, applicableCategories: [.beverage])

        let exemptItem = BillItem(id: UUID(), name: "Pizza", category: .food, price: 20.0, quantity: 1, exemptTaxes: [tax1.id])

        let billItems: [ItemCategory: OrderedSet<BillItem>] = [
            .food: [exemptItem],
            .beverage: [BillItem(id: UUID(), name: "Wine", category: .beverage, price: 50.0, quantity: 1)]
        ]

        let (subtotal, taxTotal, postTaxTotal) = taxCalculator.calculateTaxTotals(for: billItems, using: [tax1, tax2])

        XCTAssertEqual(subtotal, 70.0)
        XCTAssertEqual(taxTotal, 50.0 * 0.05, accuracy: 0.01) // Only drink is taxed
        XCTAssertEqual(postTaxTotal, subtotal + taxTotal, accuracy: 0.01)
    }
    
    func testCalculateTaxTotals_WithMultipleQuantities() {
        let tax1 = Tax(id: UUID(), name: "Sales Tax", rate: 0.10, applicableCategories: [.food])
        let tax2 = Tax(id: UUID(), name: "Luxury Tax", rate: 0.05, applicableCategories: [.beverage])

        let billItems: [ItemCategory: OrderedSet<BillItem>] = [
            .food: [BillItem(id: UUID(), name: "Pizza", category: .food, price: 20.0, quantity: 3)],
            .beverage: [BillItem(id: UUID(), name: "Wine", category: .beverage, price: 50.0, quantity: 2)]
        ]

        let (subtotal, taxTotal, postTaxTotal) = taxCalculator.calculateTaxTotals(for: billItems, using: [tax1, tax2])

        let expectedSubtotal: Decimal = (20.0 * 3) + (50.0 * 2)  // 60.0 + 100.0 = 160.0
        let expectedTaxTotal: Decimal = ((20.0 * 3) * 0.10) + ((50.0 * 2) * 0.05)  // (60 * 0.10) + (100 * 0.05) = 6.0 + 5.0 = 11.0
        let expectedPostTaxTotal: Decimal = expectedSubtotal + expectedTaxTotal  // 160.0 + 11.0 = 171.0

        XCTAssertEqual(subtotal, expectedSubtotal, accuracy: 0.01)
        XCTAssertEqual(taxTotal, expectedTaxTotal, accuracy: 0.01)
        XCTAssertEqual(postTaxTotal, expectedPostTaxTotal, accuracy: 0.01)
    }
}

