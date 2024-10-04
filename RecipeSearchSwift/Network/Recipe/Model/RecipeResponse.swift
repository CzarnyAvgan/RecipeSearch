//
//  RecipeResponse.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 04/10/2024.
//

import Foundation

struct RecipeResponse: Codable {
    let hits: [Hit]?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case hits = "hits"
        case links = "_links"
    }
}

struct Hit: Codable {
    let recipe: Recipe?
}

struct Links: Codable {
    let next: Next?
}

struct Next: Codable {
    let href, title: String?
}
