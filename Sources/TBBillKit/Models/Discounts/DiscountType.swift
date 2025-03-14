//
//  DiscountType.swift
//
//
//  Created by Alex Mitchell on 2025-03-11.
//

import Foundation

public enum DiscountType: Equatable {
    case percentage(Decimal)
    case fixedAmount(Decimal)
}
