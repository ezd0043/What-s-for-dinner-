//
//  RecipeDetailView.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//
import SwiftUI

struct RecipeDetailView: View {
    var recipe: RecipeDetail

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                
                // Debugging - to check why recipe isnt showing
                Text(recipe.title)
                    .font(.title)
                    .padding()
                    .onAppear {
                        print("Recipe title: \(recipe.title)")
                    }

                // Instructions
                if let instructions = recipe.instructions, !instructions.isEmpty {
                    Text("Instructions")
                        .font(.headline)
                        .padding(.top)
                    Text(instructions)
                        .padding()
                        .onAppear {
                            print("Instructions: \(instructions)")
                        }
                } else {
                    Text("No instructions provided.")
                        .padding()
                        .onAppear {
                            print("No instructions available for this recipe.")
                        }
                }

                // Ingredients
                if let ingredients = recipe.ingredients, !ingredients.isEmpty {
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.top)
                    ForEach(ingredients, id: \.name) { ingredient in
                        Text("\(ingredient.amount) \(ingredient.unit) \(ingredient.name)")
                            .padding(.bottom, 2)
                            .onAppear {
                                print("Ingredient: \(ingredient.name)")
                            }
                    }
                } else {
                    Text("No ingredients listed.")
                        .padding()
                        .onAppear {
                            print("No ingredients available for this recipe.")
                        }
                }
            }
        }
        .navigationTitle(recipe.title)
    }
}
