//
//  BillItem.swift
//  
//
//  Created by Alex Mitchell on 2025-03-11.
//

import Foundation

public struct BillItem: Identifiable, Hashable {
    
    public let id: UUID
    public let name: String
    public let category: ItemCategory
    public let price: Decimal
    public var quantity: Int
    public let exemptTaxes: Set<UUID>
    
    public init(
        id: UUID = UUID(),
        name: String,
        category: ItemCategory,
        price: Decimal,
        quantity: Int = 0,
        exemptTaxes: Set<UUID> = []
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.price = price
        self.quantity = quantity
        self.exemptTaxes = exemptTaxes
    }
    
    public static func == (lhs: BillItem, rhs: BillItem) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public mutating func increaseQuantity() {
        quantity += 1
    }

    public mutating func decreaseQuantity() {
        quantity = max(quantity - 1, 0)
    }
}
