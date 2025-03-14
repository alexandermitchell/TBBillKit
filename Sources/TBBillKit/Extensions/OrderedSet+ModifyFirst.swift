//
//  OrderedSet+ModifyFirst.swift
//
//
//  Created by Alex Mitchell on 2025-03-13.
//

import Foundation

public extension OrderedSet {
    /// Helper function to modify element in place
    mutating func modifyFirst(where predicate: (Element) -> Bool, modify: (inout Element) -> Void) -> Element? {
        if let index = firstIndex(where: predicate) {
            var item = self[index]  // Get the existing item
            modify(&item)           // Modify it
            update(item, at: index) // Efficiently replace in-place
            return self[index]
        }
        return nil
    }
}
