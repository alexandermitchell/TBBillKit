//
//  DiscountTests.swift
//
//
//  Created by Alex Mitchell on 2025-03-14.
//

import XCTest
@testable import TBBillKit

final class DiscountTests: XCTestCase {
    
    func testInitialization() {
        let id = UUID()
        let discount = Discount(id: id, name: "50 off", type: .fixedAmount(50.00))
        
        XCTAssertEqual(discount.id, id)
        XCTAssertEqual(discount.name, "50 off")
        XCTAssertEqual(discount.type, .fixedAmount(50.00))
    }
    
    func testEquality() {
        let id = UUID()
        let discount1 = Discount(id: id, name: "Winterlicious", type: .fixedAmount(5))
        let discount2 = Discount(id: id, name: "Winterlicious", type: .fixedAmount(5))
        
        XCTAssertEqual(discount1, discount2)
    }
    
    func testInequality() {
        let discount1 = Discount(id: UUID(), name: "Summer Special", type: .percentage(15))
        let discount2 = Discount(id: UUID(), name: "Summer Special", type: .percentage(15))
        
        XCTAssertNotEqual(discount1, discount2) // Different UUIDs
    }
    
    func testHashing() {
        let id = UUID()
        let discount1 = Discount(id: id, name: "VIP Discount", type: .fixedAmount(20))
        let discount2 = Discount(id: id, name: "VIP Discount", type: .fixedAmount(20))
        
        XCTAssertEqual(discount1.hashValue, discount2.hashValue)
    }
}

