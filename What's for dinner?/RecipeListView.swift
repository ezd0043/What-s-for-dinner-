//
//  RecipeListView.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//

import SwiftUI

struct RecipeListView: View {
    @ObservedObject var viewModel: RecipesViewModel
    var category: String
    
    var body: some View {
        List(viewModel.detailedRecipes) { recipe in
            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                RecipeRow(recipe: recipe)
            }
        }
        .navigationTitle("\(category) Recipes")
        .onAppear {
            viewModel.loadRecipes(for: category)
        }
    }
}


