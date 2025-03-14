//
//  BillItemTests.swift
//
//
//  Created by Alex Mitchell on 2025-03-14.
//

import XCTest
@testable import TBBillKit

final class BillItemTests: XCTestCase {
    
    func testInitialization() {
        let id = UUID()
        let category = ItemCategory.food
        let exemptTaxes: Set<UUID> = [UUID()]
        
        let item = BillItem(
            id: id,
            name: "Burger",
            category: category,
            price: Decimal(5.99),
            quantity: 2,
            exemptTaxes: exemptTaxes
        )
        
        XCTAssertEqual(item.id, id)
        XCTAssertEqual(item.name, "Burger")
        XCTAssertEqual(item.category, category)
        XCTAssertEqual(item.price, Decimal(5.99))
        XCTAssertEqual(item.quantity, 2)
        XCTAssertEqual(item.exemptTaxes, exemptTaxes)
    }
    
    func testDefaultInitialization() {
        let item = BillItem(name: "Soda", category: .beverage, price: Decimal(2.99))
        
        XCTAssertEqual(item.name, "Soda")
        XCTAssertEqual(item.category, .beverage)
        XCTAssertEqual(item.price, Decimal(2.99))
        XCTAssertEqual(item.quantity, 0)
        XCTAssertTrue(item.exemptTaxes.isEmpty)
    }
    
    func testEquality() {
        let id = UUID()
        let item1 = BillItem(id: id, name: "Pizza", category: .food, price: Decimal(9.99))
        let item2 = BillItem(id: id, name: "Pizza", category: .food, price: Decimal(9.99))
        
        XCTAssertEqual(item1, item2)
    }
    
    func testInequality() {
        let item1 = BillItem(name: "Pasta", category: .food, price: Decimal(7.99))
        let item2 = BillItem(name: "Pasta", category: .food, price: Decimal(7.99))
        
        XCTAssertNotEqual(item1, item2) // Different UUIDs
    }
    
    func testHashing() {
        let id = UUID()
        let item1 = BillItem(id: id, name: "Salad", category: .food, price: Decimal(4.99))
        let item2 = BillItem(id: id, name: "Salad", category: .food, price: Decimal(4.99))
        
        XCTAssertEqual(item1.hashValue, item2.hashValue)
    }
    
    func testIncreaseQuantity() {
        var item = BillItem(name: "Fries", category: .food, price: Decimal(3.49), quantity: 1)
        
        item.increaseQuantity()
        XCTAssertEqual(item.quantity, 2)
        
        item.increaseQuantity()
        XCTAssertEqual(item.quantity, 3)
    }
    
    func testDecreaseQuantity() {
        var item = BillItem(name: "Drink", category: .beverage, price: Decimal(1.99), quantity: 3)
        
        item.decreaseQuantity()
        XCTAssertEqual(item.quantity, 2)
        
        item.decreaseQuantity()
        XCTAssertEqual(item.quantity, 1)
        
        item.decreaseQuantity()
        XCTAssertEqual(item.quantity, 0)
        
        // Ensure it doesn't go negative
        item.decreaseQuantity()
        XCTAssertEqual(item.quantity, 0)
    }
}

