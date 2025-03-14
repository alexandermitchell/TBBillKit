//
//  Discount.swift
//
//
//  Created by Alex Mitchell on 2025-03-11.
//

import Foundation

public struct Discount: Identifiable, Hashable {
    public let id: UUID
    public let name: String
    public let type: DiscountType
    
    public init(
        id: UUID,
        name: String,
        type: DiscountType
    ) {
        self.id = id
        self.name = name
        self.type = type
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
        
    public static func == (lhs: Discount, rhs: Discount) -> Bool {
        return lhs.id == rhs.id
    }
}

public extension Discount {
    static let defaultDiscounts: [Discount] = [
        .tenPercentOff,
        .fiveDollarsOff
    ]
    
    static let tenPercentOff: Discount = Discount(
        id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
        name: "10% Off",
        type: .percentage(0.1)
    )
    
    static let fiveDollarsOff: Discount = Discount(
        id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
        name: "$5 Off",
        type: .fixedAmount(5)
    )
}
