//
//  Recipe.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//
import Foundation

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let instructions: String?
    let ingredients: [Ingredient]?
}

struct Ingredient: Codable {
    let name: String
    let amount: Double
    let unit: String
}

struct RecipeResults: Codable {
    let results: [Recipe]
}
