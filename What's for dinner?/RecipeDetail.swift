//
//  RecipeDetail.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/26/24.
//

import Foundation

// Define a struct that will capture the detailed information of a recipe.
struct RecipeDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let instructions: String?
    let ingredients: [Ingredient]?
    
    // Define the structure that matches the detailed JSON response from the API for ingredients.
    struct Ingredient: Codable, Identifiable {
        let id: UUID = UUID() // Add an id for SwiftUI's ForEach
        let name: String
        let amount: Double
        let unit: String
    }
}
