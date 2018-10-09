//
//  Filterable.swift
//  ChaseChallenge
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//


import Foundation

// Add to models to filter them with search query strings
protocol Filterable {
    func match(query: String) -> Bool
}

func filtered<T>(array: [T], query: String) -> [T] {
    let cleanQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    guard !cleanQuery.isEmpty else { return array }

    return array.filter({ (o) -> Bool in
        if let o = o as? Filterable {
            return o.match(query: cleanQuery)
        } else {
            // if object isn't Filterable, always include it
            return true
        }
    })
}
