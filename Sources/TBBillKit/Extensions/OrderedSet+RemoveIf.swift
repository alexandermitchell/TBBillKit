//
//  OrderedSet+RemoveIf.swift
//
//
//  Created by Alex Mitchell on 2025-03-13.
//

import Foundation

public extension OrderedSet {
    /// Helper function to remove element from OrderedSet to decrease need to unwrap indexes inline
    mutating func removeIf(_ element: Element, condition: (Element) -> Bool) {
        if let index = firstIndex(of: element), condition(self[index]) {
            remove(at: index)
        }
    }
}

