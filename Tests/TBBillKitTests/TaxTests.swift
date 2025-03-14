//
//  TaxTests.swift
//
//
//  Created by Alex Mitchell on 2025-03-14.
//

import XCTest
@testable import TBBillKit

final class TaxTests: XCTestCase {
    
    func testInitialization() {
        let id = UUID()
        let applicableCategories: Set<ItemCategory> = [.food, .beverage]
        
        let tax = Tax(
            id: id,
            name: "Sales Tax",
            rate: Decimal(0.08),
            applicableCategories: applicableCategories
        )
        
        XCTAssertEqual(tax.id, id)
        XCTAssertEqual(tax.name, "Sales Tax")
        XCTAssertEqual(tax.rate, Decimal(0.08))
        XCTAssertEqual(tax.applicableCategories, applicableCategories)
    }
    
    func testEquality() {
        let id = UUID()
        let tax1 = Tax(id: id, name: "VAT", rate: Decimal(0.15), applicableCategories: [.food])
        let tax2 = Tax(id: id, name: "VAT", rate: Decimal(0.15), applicableCategories: [.food])
        
        XCTAssertEqual(tax1, tax2)
    }
    
    func testInequality() {
        let tax1 = Tax(id: UUID(), name: "GST", rate: Decimal(0.05), applicableCategories: [.beverage])
        let tax2 = Tax(id: UUID(), name: "GST", rate: Decimal(0.05), applicableCategories: [.beverage])
        
        XCTAssertNotEqual(tax1, tax2) // Different UUIDs
    }
    
    func testHashing() {
        let id = UUID()
        let tax1 = Tax(id: id, name: "Alcohol Tax", rate: Decimal(0.10), applicableCategories: [.alcohol])
        let tax2 = Tax(id: id, name: "Alcohol Tax", rate: Decimal(0.10), applicableCategories: [.alcohol])
        
        XCTAssertEqual(tax1.hashValue, tax2.hashValue)
    }
}

