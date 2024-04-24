//
//  RecipeDetailView.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//

import Foundation
import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: recipe.image)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(height: 300)

                Text(recipe.title)
                    .font(.title)
                    .padding()

                if let instructions = recipe.instructions {
                    Text("Instructions")
                        .font(.headline)
                        .padding(.top)
                    Text(instructions)
                        .padding()
                }

                if let ingredients = recipe.ingredients {
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.top)
                    ForEach(ingredients, id: \.name) { ingredient in
                        Text("\(ingredient.amount) \(ingredient.unit) \(ingredient.name)")
                            .padding(.bottom, 2)
                    }
                }
            }
        }
        .navigationTitle(recipe.title)
    }
}
