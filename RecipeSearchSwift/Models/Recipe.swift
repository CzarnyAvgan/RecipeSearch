//
//  Recipe.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 04/10/2024.
//

import Foundation

struct Recipe: Codable {
    let label: String?
    let image: String?
    let calories: Float?
    let totalNutrients: TotalNutrient?
}

struct TotalNutrient: Codable {
    let fat: Nutrient?
    let carb: Nutrient?
    let protein: Nutrient?
    
    enum CodingKeys: String, CodingKey {
        case fat = "FAT"
        case carb = "CHOCDF"
        case protein = "PROCNT"
    }
}

struct Nutrient: Codable {
    let label: String?
    let quantity: Float?
    let unit: String?
}
