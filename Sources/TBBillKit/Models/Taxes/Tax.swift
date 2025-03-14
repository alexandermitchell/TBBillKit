//
//  Tax.swift
//
//
//  Created by Alex Mitchell on 2025-03-11.
//

import Foundation

public struct Tax: Identifiable, Hashable {
    public let id: UUID
    public let name: String
    public let rate: Decimal
    public let applicableCategories: Set<ItemCategory>
    
    public init(
        id: UUID,
        name: String,
        rate: Decimal,
        applicableCategories: Set<ItemCategory>
    ) {
        self.id = id
        self.name = name
        self.rate = rate
        self.applicableCategories = applicableCategories
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
        
    public static func == (lhs: Tax, rhs: Tax) -> Bool {
        return lhs.id == rhs.id
    }
}

public extension Tax {
    static let defaultTaxes: Set<Tax> = [salesTax, alcoholTax]
    
    static let salesTax: Tax = Tax(
        id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
        name: "Sales Tax",
        rate: 0.07,
        applicableCategories: [.food, .beverage, .other]
    )
    
    static let alcoholTax: Tax = Tax(
        id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
        name: "Alcohol Tax",
        rate: 0.10,
        applicableCategories: [.alcohol]
    )
}
